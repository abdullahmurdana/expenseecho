import 'dart:ui';

import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class FinancialReportDetailsController extends GetxController {
  var expenses = <ExpenseModel>[].obs;
  var totalExpenseForCurrentMonth = 0.0.obs;
  var income = <IncomeModel>[].obs;
  var totalIncomeForCurrentMonth = 0.0.obs;
  var isSelected = [true, false].obs;
  var chartType = [true, false].obs;
  var categoryColors = <String, Color>{}.obs;
  var isLoading = false.obs;
  var selectedDropdown = 'Transactions'.obs; // Added for dropdown selection
  var expenseCategories = <CategoryModel>[].obs; // Added for expense categories
  var incomeCategories = <CategoryModel>[].obs; // Added for income categories

  void toggleSelection(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    fetchTransactionsOrCategories(); // Fetch data based on selection
  }

  void toggleChartType(int index) {
    for (int i = 0; i < chartType.length; i++) {
      chartType[i] = i == index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchExpensesForCurrentUser();
    fetchIncomeListForCurrentUser();
    fetchCategoryColors();
    fetchExpenseCategories(); // Fetch expense categories
    fetchIncomeCategories(); // Fetch income categories
  }

  Future<void> fetchExpensesForCurrentUser() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedExpenses =
            await ExpenseHandler().getExpensesByUserId(userId: user.id ?? '');
        expenses.assignAll(fetchedExpenses!);
        calculateTotalExpenseForCurrentMonth();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch expenses');
    }
  }

  void calculateTotalExpenseForCurrentMonth() {
    var now = DateTime.now();
    var currentMonthExpenses = expenses.where((expense) {
      var expenseDate = expense.createdAtDateTime;
      return expenseDate!.year == now.year && expenseDate.month == now.month;
    }).toList();

    totalExpenseForCurrentMonth.value =
        currentMonthExpenses.fold(0.0, (sum, item) => sum + item.expenseAmount);
  }

  Future<void> fetchIncomeListForCurrentUser() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedIncomes =
            await IncomeHandler().getIncomesByUserId(userId: user.id ?? '');
        income.assignAll(fetchedIncomes!);
        calculateTotalIncomeForCurrentMonth();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch incomes');
    }
  }

  void calculateTotalIncomeForCurrentMonth() {
    var now = DateTime.now();
    var currentMonthincomes = income.where((income) {
      var incomeDate = income.createdAtDateTime!;
      return incomeDate.year == now.year && incomeDate.month == now.month;
    }).toList();

    totalIncomeForCurrentMonth.value =
        currentMonthincomes.fold(0.0, (sum, item) => sum + item.incomeAmount);
  }

  Future<void> fetchCategoryColors() async {
    var categories = await CategoryPreferences.loadExpenseCategories();
    for (var category in categories) {
      categoryColors[category.name] = category.foregroundColor;
    }
  }

  Future<void> fetchExpenseCategories() async {
    var categories = await CategoryPreferences.loadExpenseCategories();
    expenseCategories.assignAll(categories);
  }

  Future<void> fetchIncomeCategories() async {
    var categories = await CategoryPreferences.loadIncomeCategories();
    incomeCategories.assignAll(categories);
  }

  void fetchTransactionsOrCategories() {
    if (selectedDropdown.value == 'Transactions') {
      if (isSelected[0]) {
        fetchExpensesForCurrentUser();
      } else {
        fetchIncomeListForCurrentUser();
      }
    } else {
      if (isSelected[0]) {
        fetchExpenseCategories();
      } else {
        fetchIncomeCategories();
      }
    }
  }
}
