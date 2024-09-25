import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class ExpenseDetailsController extends GetxController {
  final ExpenseHandler _expenseHandler = ExpenseHandler();

  Future<bool> deleteExpense(ExpenseModel expenseModel) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      //* delete from local db.
      await _expenseHandler.deleteExpense(expenseId: expenseModel.id!);

      if (connectivityResult == ConnectivityResult.none) {
        print(
            '---> no internet available, adding deletion of expense to queue.');
        await QueueManager()
            .addDeleteTransactionToQueue('expense', expenseModel.id!);
        return true;
      } else {
        bool success = await ExpenseAPIService.deleteExpense(
            expenseId: expenseModel.id ?? '');

        if (!success) {
          await QueueManager()
              .addDeleteTransactionToQueue('expense', expenseModel.id!);
          return false;
        }
      }
      return true;
    } catch (e) {
      throw Exception('Failed to delete expense...');
    }
  }

  Future<AccountsModel> getAccountDetails({required String accountId}) async {
    try {
      print('---> Account ID :: Expense Details:: $accountId');
      AccountsModel? accountsModel =
          await AccountHandler().getAccountById(accountId: accountId);

      return accountsModel!;
    } catch (e) {
      throw Exception('Failed to get account info for expense...');
    }
  }
}
