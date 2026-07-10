import 'dart:convert';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;
import 'package:expenseecho/data/models/budget/budget_model.dart';

class BudgetAPIService {
  static Future<List<BudgetModel>> fetchbudgets() async {
    var uri = '${Config.baseUrl}/api/collections/budgets/records';
    final response = await http.get(Uri.parse(uri));

    print("---> JSON Status code :: Get Budget List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => BudgetModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load budget list');
    }
  }

  static Future<List<BudgetModel>> fetchBudgetListById({
    required String userId,
  }) async {
    var uri =
        '${Config.baseUrl}/api/collections/budgets/records?fields=*,user_id=$userId';
    final response = await http.get(Uri.parse(uri));

    print("---> JSON Status code :: Get Budget List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => BudgetModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load budget list');
    }
  }

  static Future<bool> createBudget({required BudgetModel budgetModel}) async {
    final uri = Uri.parse('${Config.baseUrl}/api/collections/budgets/records');
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

  static Future<bool> updateBudget({
    required BudgetModel budgetModel,
    String? budgetId,
  }) async {
    print('---> Budget ID :: update:: $budgetId ');
    print('---> Budget body :: update:: ${budgetModel.toJson()} ');
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/budgets/records/$budgetId');
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

  static Future<bool> deleteBudget({required String budgetId}) async {
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/budgets/records/$budgetId');
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
      print('Failed to delete budget: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<void> addBudgetToQueue(BudgetModel budget) async {
    await QueueManager().addTransactionToQueue('budget', budget.toMap());
  }
}
