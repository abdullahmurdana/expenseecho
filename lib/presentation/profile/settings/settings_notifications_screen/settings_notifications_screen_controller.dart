import 'package:get/get.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class SettingsNotificationsScreenController extends GetxController {
  var expenseAlert = false.obs;
  var budgetAlert = false.obs;
  var tipsArticles = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotificationSettings();
  }

  Future<void> loadNotificationSettings() async {
    expenseAlert.value =
        await SharedPreferencesHandler.getExpenseAlert() ?? false;
    budgetAlert.value =
        await SharedPreferencesHandler.getBudgetAlert() ?? false;
    tipsArticles.value =
        await SharedPreferencesHandler.getTipsArticles() ?? false;
  }

  Future<void> setExpenseAlert(bool value) async {
    expenseAlert.value = value;
    await SharedPreferencesHandler.saveExpenseAlert(value);
  }

  Future<void> setBudgetAlert(bool value) async {
    budgetAlert.value = value;
    await SharedPreferencesHandler.saveBudgetAlert(value);
  }

  Future<void> setTipsArticles(bool value) async {
    tipsArticles.value = value;
    await SharedPreferencesHandler.saveTipsArticles(value);
  }
}
