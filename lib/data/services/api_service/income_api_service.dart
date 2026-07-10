import 'dart:convert';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;
import 'package:expenseecho/data/models/income/income_model.dart';

class IncomeAPIService {
  static Future<List<IncomeModel>> fetchIncomeList() async {
    var uri = '${Config.baseUrl}/api/collections/incomes/records';
    final response = await http.get(Uri.parse(uri));

    print("---> JSON Status code :: Get Income List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => IncomeModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load income list');
    }
  }

  static Future<List<IncomeModel>> fetchIncomeListById({
    required String userId,
  }) async {
    var uri =
        '${Config.baseUrl}/api/collections/incomes/records?fields=*,user_id=$userId';
    final response = await http.get(Uri.parse(uri));

    print("---> JSON Status code :: Get Income List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => IncomeModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load income list');
    }
  }

  static Future<bool> addIncome({required IncomeModel income}) async {
    final uri = Uri.parse('${Config.baseUrl}/api/collections/incomes/records');
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

  static Future<bool> updateIncome({
    required IncomeModel incomeModel,
    String? incomeId,
  }) async {
    print('---> Income ID :: update:: $incomeId ');
    print('---> Income body :: update:: ${incomeModel.toJson()} ');
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/incomes/records/$incomeId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: incomeModel.toJson(),
    );
    print('---> URL :: update:: $uri ');
    print('---> Status code :: update:: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update income: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<bool> deleteIncome({required String incomeId}) async {
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/incomes/records/$incomeId');
    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('---> URL :: delete:: $uri ');
    print('---> Status code :: delete:: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete income: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<void> addIncomeToQueue(IncomeModel income) async {
    await QueueManager().addTransactionToQueue('income', income.toMap());
  }
}
