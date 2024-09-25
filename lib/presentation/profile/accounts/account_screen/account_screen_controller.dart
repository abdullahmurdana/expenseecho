import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/account_db_handler.dart';
import 'package:get/get.dart';

class AccountScreenController extends GetxController {
  var accounts = <AccountsModel>[].obs;
  var isLoading = true.obs;
  var userModel = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      userModel.value = await UserPreferences.getUserData();
    } catch (e) {
      throw Exception("Failed to get user data :: account screen ::");
    }
  }

  Future<void> fetchAccounts() async {
    try {
      isLoading(true);

      UserModel? user = await UserPreferences.getUserData();
      if (user == null) {
        throw Exception(
            '---> Accounts Screen Controller :: User data not found in SharedPreferences');
      }
      // filtering by user id from all accounts.
      /*
          .where((account) => account.id == user.id ?? '')
      */

      var fetchedAccounts =
          await AccountHandler().getAccountsByUserId(userId: user.id ?? '');
      print(
          "---> Fetched Accounts :: Account Screen :: ${fetchedAccounts.toString()}");
      accounts.assignAll(fetchedAccounts!);
    } catch (e) {
      print("Error fetching accounts: $e");
    } finally {
      isLoading(false);
    }
  }
}
