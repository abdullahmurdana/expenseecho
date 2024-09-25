import 'dart:convert';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;
import 'package:expenseecho/data/models/expense/expense_model.dart';

class ExpenseAPIService {
  static Future<List<ExpenseModel>> fetchExpenses() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/collections/expenses/records'),
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

  static Future<List<ExpenseModel>> fetchExpensesById({
    required String userId,
  }) async {
    var uri =
        '${Config.baseUrl}/api/collections/expenses/records?fields=*,user_id=$userId';
    final response = await http.get(Uri.parse(uri));

    print("---> JSON Status code :: Get Expense List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => ExpenseModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load expenses');
    }
  }

  static Future<bool> addExpense({required ExpenseModel expense}) async {
    final uri = Uri.parse('${Config.baseUrl}/api/collections/expenses/records');
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

  static Future<bool> updateExpense({
    required ExpenseModel expenseModel,
    String? expenseId,
  }) async {
    print('---> Expense ID :: update:: $expenseId ');
    print('---> Expense body :: update:: ${expenseModel.toJson()} ');
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/expenses/records/$expenseId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: expenseModel.toJson(),
    );
    print('---> URL :: update:: $uri ');
    print('---> Status code :: update:: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update expense: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<bool> deleteExpense({required String expenseId}) async {
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/expenses/records/$expenseId');
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
      print('Failed to delete expense: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<void> addExpenseToQueue(ExpenseModel expense) async {
    await QueueManager().addTransactionToQueue('expense', expense.toMap());
  }
}
