import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/budget_db_handler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BudgetListViewController extends GetxController {
  var budgetsList = <BudgetModel>[].obs;
  var isLoading = false.obs;
  var selectedMonth = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    getBudgets();
  }

  String get selectedMonthName {
    return DateFormat.MMMM().format(selectedMonth.value);
  }

  Future<void> getBudgets() async {
    isLoading.value = true;
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        print('---> UserID :: getBudgets :: ${user.id}');
        var fetchedBudgetList =
            await BudgetHandler().getBudgetsByUserId(userId: user.id ?? '');
        print(
            '---> Budget List Len :: getBudgets :: ${fetchedBudgetList.toString()}');
        if (fetchedBudgetList!.isNotEmpty) {
          budgetsList.assignAll(fetchedBudgetList);
        } else {
          print('---> Fetched budget list is empty.');
        }
      } else {
        print('---> User data is null.');
      }
    } catch (e) {
      throw Exception('Failed to get budget list :: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeMonth(int increment) {
    selectedMonth.value = DateTime(
      selectedMonth.value.year,
      selectedMonth.value.month + increment,
    );
    getBudgets();
  }
}
