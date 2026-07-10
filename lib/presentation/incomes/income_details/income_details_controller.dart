import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class IncomeDetailsController extends GetxController {
  final IncomeHandler _incomeHandler = IncomeHandler();

  Future<bool> deleteIncome(IncomeModel incomeModel) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      //* delete from local db.
      await _incomeHandler.deleteIncome(id: incomeModel.id!);

      if (connectivityResult == ConnectivityResult.none) {
        print(
            '---> no internet available, adding deletion of income to queue.');
        await QueueManager()
            .addDeleteTransactionToQueue('income', incomeModel.id!);
        return true;
      } else {
        bool success =
            await IncomeAPIService.deleteIncome(incomeId: incomeModel.id ?? '');

        if (!success) {
          await QueueManager()
              .addDeleteTransactionToQueue('income', incomeModel.id!);
          return false;
        }
      }
      return true;
    } catch (e) {
      throw Exception('Failed to delete income...');
    }
  }

  Future<AccountsModel> getAccountDetails({required String accountId}) async {
    try {
      print('---> Account ID :: income Details:: $accountId');
      AccountsModel? accountsModel =
          await AccountHandler().getAccountById(accountId: accountId);

      return accountsModel!;
    } catch (e) {
      throw Exception('Failed to get account info for income...');
    }
  }
}
