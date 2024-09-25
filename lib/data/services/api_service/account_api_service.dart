import 'dart:convert';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;
import 'package:expenseecho/data/models/accounts/accounts_model.dart';

class AccountAPIService {
  static Future<List<AccountsModel>> fetchAccounts() async {
    var uri = '${Config.baseUrl}/api/collections/accounts/records';
    final response = await http.get(Uri.parse(uri));

    print(
        "---> JSON Status code :: Get Account List :: ${response.statusCode}");
    // print("---> URL :: Get Account List :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) {
        return AccountsModel.fromMap(item);
      }).toList();
    } else {
      throw Exception('---> Failed to load accounts list');
    }
  }

  static Future<List<AccountsModel>> fetchAccountsByUserID({
    required String userId,
  }) async {
    var uri =
        '${Config.baseUrl}/api/collections/accounts/records?fields=*,user_id=$userId';
    final response = await http.get(Uri.parse(uri));

    print(
        "---> JSON Status code :: Get Account List by ID :: ${response.statusCode}");
    // print("---> URL :: Get Account List by ID :: $uri");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) {
        return AccountsModel.fromMap(item);
      }).toList();
    } else {
      throw Exception('---> Failed to load accounts list');
    }
  }

  static Future<bool> updateAccountBalance({
    required String accountId,
    required double newBalance,
  }) async {
    final String uri =
        '${Config.baseUrl}/api/collections/accounts/records/$accountId';

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

  static fetchAccountDetailsById({required String accountId}) async {
    final response = await http.get(
      Uri.parse(
          '${Config.baseUrl}/api/collections/accounts/records/:$accountId'),
    );

    print("---> JSON Status code :: Get Account Info ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return AccountsModel.fromMap(data);
    } else {
      throw Exception('---> Failed to load account details');
    }
  }

  static Future<bool> createAccount({required AccountsModel account}) async {
    try {
      final uri =
          Uri.parse('${Config.baseUrl}/api/collections/accounts/records');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(account.toMap()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  static Future<bool> updateAccount(
      {required String accountId, required AccountsModel account}) async {
    try {
      final uri = Uri.parse(
          '${Config.baseUrl}/api/collections/accounts/records/$accountId');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(account.toMap()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update budget: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      throw Exception('Failed to update account: $e');
    }
  }

  static Future<void> addAccountToQueue(AccountsModel account) async {
    await QueueManager().addTransactionToQueue('account', account.toMap());
  }
}
