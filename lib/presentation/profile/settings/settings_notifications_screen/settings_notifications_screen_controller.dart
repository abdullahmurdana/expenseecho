import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:get/get.dart';

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
    expenseAlert.value = await AlertPreferences.getExpenseAlert() ?? false;
    budgetAlert.value = await AlertPreferences.getBudgetAlert() ?? false;
    tipsArticles.value = await AlertPreferences.getTipsArticles() ?? false;
  }

  Future<void> setExpenseAlert(bool value) async {
    expenseAlert.value = value;
    await AlertPreferences.saveExpenseAlert(value);
  }

  Future<void> setBudgetAlert(bool value) async {
    budgetAlert.value = value;
    await AlertPreferences.saveBudgetAlert(value);
  }

  Future<void> setTipsArticles(bool value) async {
    tipsArticles.value = value;
    await AlertPreferences.saveTipsArticles(value);
  }
}
