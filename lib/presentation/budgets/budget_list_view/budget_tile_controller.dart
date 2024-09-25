import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class BudgetTileController extends GetxController {
  var selectedCategory = Rx<CategoryModel?>(null);
  var expenses = <ExpenseModel>[].obs;
  var totalExpenseForCurrentMonth = 0.0.obs;

  BudgetTileController(String categoryName) {
    fetchCategories(categoryName);
    fetchExpensesForCurrentUser();
  }

  Future<void> fetchCategories(String categoryName) async {
    var categories = <CategoryModel>[];
    var expenseCategories = await CategoryPreferences.loadExpenseCategories();

    categories = [
      ...expenseCategories,
    ];

    var currentCategory = categories.firstWhere(
      (category) => categoryName == category.name,
    );

    selectedCategory.value = currentCategory;
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
      return expenseDate!.year == now.year &&
          expenseDate.month == now.month &&
          expense.category == selectedCategory.value!.name;
    }).toList();

    totalExpenseForCurrentMonth.value =
        currentMonthExpenses.fold(0.0, (sum, item) => sum + item.expenseAmount);
  }

  void getTotalExpenseAmount(String categoryName) {}
}
