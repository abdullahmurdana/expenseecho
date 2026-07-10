/* import 'dart:convert';

import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServiceHttp {
  static const String baseUrl = 'https://7503-103-72-2-73.ngrok-free.app';

  /* static Future<Map<String, dynamic>> signInHttp({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/collections/users/auth-with-password'),
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
      Uri.parse('$baseUrl/api/password_resets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset email');
    }
  }

  static Future<void> resetPassword(String token, String newPassword) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/password_resets/$token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"password": newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  } */

  // Getting all accounts and then filter according to user.
  /* static Future<List<AccountsModel>> fetchAccounts() async {
    var uri = '$baseUrl/api/collections/accounts/records';
    final response = await http.get(
      Uri.parse(uri),
    );

    print(
        "---> JSON Status code :: Get Account List :: ${response.statusCode}");
    print("---> URL :: Get Account List :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      // Get the user data from SharedPreferences
      UserModel? user = await UserPreferences.getUserData();
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
    var uri =
        '$baseUrl/api/collections/accounts/records?fields=*,user_id=$userId';
    final response = await http.get(
      Uri.parse(uri),
    );

    print(
        "---> JSON Status code :: Get Account List by ID :: ${response.statusCode}");
    print("---> URL :: Get Account List by ID :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      // print("---> Fetch Accounts By ID ::Items: $items");

      // Map the items to AccountsModel
      return items.map((item) {
        // print("---> Item: $item");
        return AccountsModel.fromMap(item);
      }).toList();
    } else {
      throw Exception('---> Failed to load accounts list');
    }
  } */

  static Future<List<ExpenseModel>> fetchExpenses() async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/collections/expenses/records',
      ),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Expense List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => ExpenseModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load expenses');
    }
  }

  static Future<List<ExpenseModel>> fetchExpensesById(
      {required String userId}) async {
    var uri =
        '$baseUrl/api/collections/expenses/records?fields=*,user_id=$userId';
    final response = await http.get(
      Uri.parse(
        uri,
      ),
    );

    print("---> JSON Status code :: Get Expense List ::${response.statusCode}");
    // print("---> URL :: Get Expense List by ID :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      // print("Items :: Expense :: ${items.toString()}");

      return items.map((item) => ExpenseModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load expenses');
    }
  }

  static Future<List<IncomeModel>> fetchIncomeList() async {
    var uri = '$baseUrl/api/collections/incomes/records';
    final response = await http.get(
      Uri.parse(uri),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Income List ::${response.statusCode}");
    // print("---> URL :: Get Account List :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => IncomeModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load income list');
    }
  }

  static Future<List<IncomeModel>> fetchIncomeListById(
      {required String userId}) async {
    var uri =
        '$baseUrl/api/collections/incomes/records?fields=*,user_id=$userId';
    final response = await http.get(
      Uri.parse(uri),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Income List ::${response.statusCode}");
    // print("---> URL :: Get Income List by ID :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => IncomeModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load income list');
    }
  }

  static Future<List<BudgetModel>> fetchBudgetListById(
      {required String userId}) async {
    var uri =
        '$baseUrl/api/collections/budgets/records?fields=*,user_id=$userId';
    final response = await http.get(
      Uri.parse(uri),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Budget List ::${response.statusCode}");
    // print("---> URL :: Get Budget List by ID :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      // print('---> Budget list :: ${items.toString()}');
      return items.map((item) => BudgetModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load budget list');
    }
  }

  static Future<List<TransfersModel>> fetchTransfers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/collections/transfers/records'),
      // headers: headers,
    );

    print(
        "---> JSON Status code :: Get Transfer List ::${response.statusCode}");
    print(
        "---> JSON Status code :: Get Transfer List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      print("---> JSON Status code :: Transfer List ::${items.toString()}");

      return items.map((item) => TransfersModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load transfer list');
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
      Uri.parse('$baseUrl/api/collections/transfers/records'),
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

  static Future<bool> updateAccountBalance(
      {required String accountId, required double newBalance}) async {
    final String uri = '$baseUrl/api/collections/accounts/records/$accountId';

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
      print('---> Account balance updated successfully.');
      return true;
    } else {
      print(
          '---> Failed to update account balance. Status code: ${response.statusCode}');
      throw Exception('Failed to update account balance');
    }
  }

  static Future<bool> addExpense({required ExpenseModel expense}) async {
    final uri = Uri.parse('$baseUrl/api/collections/expenses/records');
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

  static Future<bool> createBudget({required BudgetModel budgetModel}) async {
    final uri = Uri.parse('$baseUrl/api/collections/budgets/records');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: budgetModel.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to add budget: ${response.statusCode}');
      return false;
    }
  }

  static Future<bool> updateBudget(
      {required BudgetModel budgetModel, String? budgetId}) async {
    print('---> Budget ID :: update:: $budgetId ');
    print('---> Budget body :: update:: ${budgetModel.toJson()} ');
    final uri = Uri.parse('$baseUrl/api/collections/budgets/records/$budgetId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: budgetModel.toJson(),
    );
    print('---> URL :: update:: $uri ');
    print('---> Status code :: update:: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update budget: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<bool> addIncome({required IncomeModel income}) async {
    final uri = Uri.parse('$baseUrl/api/collections/incomes/records');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: income.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to add income: ${response.statusCode}');
      return false;
    }
  }

  static fetchAccountDeatilsById({required String accountId}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/collections/accounts/records/:$accountId'),
      // headers: headers,
    );

    print("---> JSON Status code :: Get Account Info ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return AccountsModel.fromMap(data);
    } else {
      throw Exception('---> Failed to load transfer list');
    }
  }
}
 */