import 'dart:convert';

import 'package:expenseecho/data/models/accounts/accounts_model.dart';
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

  static sendResetEmail(String value) {}

  static resetPassword(String value, String value2) {}

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
}
