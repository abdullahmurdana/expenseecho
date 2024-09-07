import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:expenseecho/data/services/api_service_http.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class AccountScreenController extends GetxController {
  var accounts = <AccountsModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
  }

  Future<void> fetchAccounts() async {
    try {
      isLoading(true);

      UserModel? user = await SharedPreferencesHandler.getUserData();
      if (user == null) {
        throw Exception(
            '---> Accounts Screen Controller :: User data not found in SharedPreferences');
      }
      // filtering by user id from all accounts.
      /*
          .where((account) => account.userId == user.userId)
      */

      var fetchedAccounts =
          await ApiServiceHttp.fetchAccountsByUserID(userId: user.userId);
      accounts.assignAll(fetchedAccounts);
    } catch (e) {
      print("Error fetching accounts: $e");
    } finally {
      isLoading(false);
    }
  }
}
