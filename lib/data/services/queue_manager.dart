import 'dart:convert';
import 'package:expenseecho/core/network/connectivity_service.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/queue_db_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';

class QueueManager {
  static final QueueManager _instance = QueueManager._internal();
  factory QueueManager() => _instance;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  QueueManager._internal() {
    _init();
  }

  void _init() {
    // Initialize connectivity check
    ConnectivityService.instance.checkConnection();
  }

  Future<void> addTransactionToQueue(String type, Map<String, dynamic> data,
      {String? id}) async {
    await QueueHandler.insertTransaction(
        type: type, data: jsonEncode(data), id: id);
    syncPendingTransactions();
  }

  Future<void> syncPendingTransactions() async {
    List<Map<String, dynamic>> transactions =
        await QueueHandler.getPendingTransactions();
    for (var transaction in transactions) {
      bool success = await _processTransaction(transaction);
      if (success) {
        await QueueHandler.deleteTransaction(id: transaction['id']);
      }
    }
  }

  Future<bool> _processTransaction(Map<String, dynamic> transaction) async {
    String type = transaction['type'];
    Map<String, dynamic> data = jsonDecode(transaction['data']);

    try {
      switch (type) {
        case 'expense':
          return await ExpenseAPIService.addExpense(
              expense: ExpenseModel.fromMap(data));
        case 'income':
          return await IncomeAPIService.addIncome(
              income: IncomeModel.fromMap(data));
        case 'budget':
          return await BudgetAPIService.createBudget(
              budgetModel: BudgetModel.fromMap(data));
        case 'update_expense':
          return await ExpenseAPIService.updateExpense(
            expenseId: data['id'],
            expenseModel: ExpenseModel.fromMap(data),
          );
        case 'delete_expense':
          return await ExpenseAPIService.deleteExpense(expenseId: data['id']);
        case 'update_income':
          return await IncomeAPIService.updateIncome(
              incomeId: data['id'], incomeModel: IncomeModel.fromMap(data));
        case 'delete_income':
          return await IncomeAPIService.deleteIncome(incomeId: data['id']);
        case 'update_budget':
          return await BudgetAPIService.updateBudget(
              budgetModel: BudgetModel.fromMap(data), budgetId: data['id']);
        case 'delete_budget':
          return await BudgetAPIService.deleteBudget(budgetId: data['id']);
        case 'transfer':
          return await TransferAPIService.createTransfer(
            userId: data['user_id'],
            fromAccountId: data['from_account_id'],
            toAccountId: data['to_account_id'],
            description: data['description'],
            amount: data['amount'],
          );
        case 'update_transfer':
          return await TransferAPIService.updateTransfer(
              transferModel: TransfersModel.fromMap(data),
              transferId: data['id']);
        case 'delete_transfer':
          return await TransferAPIService.deleteTransfer(
              transferId: data['id']);
        case 'account':
          return await AccountAPIService.createAccount(
              account: AccountsModel.fromMap(data));
        case 'update_account':
          return await AccountAPIService.updateAccount(
            accountId: data['id'],
            account: AccountsModel.fromMap(data),
          );
        case 'delete_account':
          return await ExpenseAPIService.deleteExpense(expenseId: data['id']);
        default:
          return false;
      }
    } catch (e) {
      print('Failed to process transaction: $e');
      return false;
    }
  }

  Future<void> addUpdateTransactionToQueue(
      String type, Map<String, dynamic> data, String id) async {
    await addTransactionToQueue('update_$type', data, id: id);
  }

  Future<void> addDeleteTransactionToQueue(String type, String id) async {
    await addTransactionToQueue('delete_$type', {'id': id}, id: id);
  }
}
