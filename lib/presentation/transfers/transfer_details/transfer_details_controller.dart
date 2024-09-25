import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class TransferDetailsController extends GetxController {
  final TransferHandler _transferHandler = TransferHandler();

  Future<bool> deleteTransfer(TransfersModel transferModel) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      //* delete from local db.
      await _transferHandler.deleteTransfer(id: transferModel.id!);

      if (connectivityResult == ConnectivityResult.none) {
        print(
            '---> no internet available, adding deletion of transfer to queue.');
        await QueueManager()
            .addDeleteTransactionToQueue('transfer', transferModel.id!);
        return true;
      } else {
        bool success = await TransferAPIService.deleteTransfer(
            transferId: transferModel.id ?? '');

        if (!success) {
          await QueueManager()
              .addDeleteTransactionToQueue('transfer', transferModel.id!);
          return false;
        }
      }
      return true;
    } catch (e) {
      throw Exception('Failed to delete transfer...');
    }
  }

  Future<AccountsModel> getAccountDetails({required String accountId}) async {
    try {
      print('---> Account ID :: Expense Details:: $accountId');
      AccountsModel? accountsModel =
          await AccountHandler().getAccountById(accountId: accountId);

      return accountsModel!;
    } catch (e) {
      throw Exception('---> Failed to get account info for expense...');
    }
  }
}
