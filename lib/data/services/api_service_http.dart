import 'dart:convert';

import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';
import 'package:http/http.dart' as http;

class ApiServiceHttp {
  static const String url = 'https://b6ca-59-103-219-14.ngrok-free.app';

  static Future<Map<String, dynamic>> signInHttp({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/api/collections/users/auth-with-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"identity": identity, "password": password}),
      );

      print("---> API Service :: Response Code :: ${response.statusCode}");
      print("---> API Service :: Response reason  :: ${response.reasonPhrase}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        throw Exception(
            '---> Failed to SignIn: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('---> Error during sign-in: $e');
      throw Exception('---> Error during sign-in');
    }
  }

  // Method to request a password reset email
  static Future<void> sendResetEmail(String email) async {
    final response = await http.post(
      Uri.parse('$url/api/password_resets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset email');
    }
  }

  static Future<void> resetPassword(String token, String newPassword) async {
    final response = await http.patch(
      Uri.parse('$url/api/password_resets/$token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"password": newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  // Getting all accounts and then filter according to user.
  static Future<List<AccountsModel>> fetchAccounts() async {
    final response = await http.get(
      Uri.parse('$url/api/collections/accounts/records'),
    );

    print(
        "---> JSON Status code :: Get Account List :: ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      // Get the user data from SharedPreferences
      UserModel? user = await SharedPreferencesHandler.getUserData();
      if (user == null) {
        throw Exception('---> User data not found in SharedPreferences');
      }

      print("---> Fetch Accounts ::Items: $items");
      print("---> Fetch Accounts ::User: ${user.userId}");

      // Filter the accounts based on userId
      return items.map((item) {
        print("---> Item: $item");
        return AccountsModel.fromMap(item);
      }).toList();
    } else {
      throw Exception('---> Failed to load accounts list');
    }
  }

  // Getting only accounts with the user associated.
  static Future<List<AccountsModel>> fetchAccountsByUserID(
      {required String userId}) async {
    // Get the user data from SharedPreferences
    final response = await http.get(
      Uri.parse(
          '$url/api/collections/accounts/records?fields=*,user_id=$userId'),
    );

    print(
        "---> JSON Status code :: Get Account List :: ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      print("---> Fetch Accounts By ID ::Items: $items");

      // Map the items to AccountsModel
      return items.map((item) {
        print("---> Item: $item");
        return AccountsModel.fromMap(item);
      }).toList();
    } else {
      throw Exception('---> Failed to load accounts list');
    }
  }

  Future<List<ExpenseModel>> fetchExpenses() async {
    final response = await http.get(
      Uri.parse(
        '$url/api/collections/expenses/records',
      ),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Expense List ::${response.headers}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => ExpenseModel.fromJson(item)).toList();
    } else {
      throw Exception('---> Failed to load expenses');
    }
  }

  Future<List<IncomeModel>> fetchIncomeList() async {
    final response = await http.get(
      Uri.parse('$url/api/collections/income/records'),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Income List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => IncomeModel.fromJson(item)).toList();
    } else {
      throw Exception('---> Failed to load income list');
    }
  }

  // Method to create a transfer
  static Future<bool> createTransfer({
    required String userId,
    required String fromAccountId,
    required String toAccountId,
    required String description,
    required double amount,
  }) async {
    final Map<String, dynamic> body = {
      'user_id': userId,
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'description': description,
      'amount': amount,
    };

    final response = await http.post(
      Uri.parse('$url/api/collections/transfers/records'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    print("---> JSON Status code :: Create Transfer :: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("---> Transfer created successfully");
      return true;
    } else {
      print("---> Failed to create transfer: ${response.body}");
      throw Exception('---> Failed to create transfer');
    }
  }

  static Future<void> updateAccountBalance(
      {required String accountId, required double newBalance}) async {
    final String uri = '$url/api/collections/accounts/records/$accountId';

    final Map<String, dynamic> body = {
      'balance': newBalance,
    };

    final response = await http.patch(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      print('Account balance updated successfully.');
    } else {
      print(
          'Failed to update account balance. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update account balance');
    }
  }

  Future<bool> addExpense(ExpenseModel expense) async {
    final uri = Uri.parse('$url/api/collections/expenses/records');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: expense.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to add expense: ${response.statusCode}');
      return false;
    }
  }
}
