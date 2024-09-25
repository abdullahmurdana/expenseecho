import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

class FinancialStoryExpenseController extends GetxController {
  var expenses = <ExpenseModel>[].obs;
  var totalExpenseForCurrentMonth = 0.0.obs;
  var highestExpense = Rxn<ExpenseModel>();
  var selectedCategory = Rxn<CategoryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchExpensesForCurrentUser();
  }

  Future<void> fetchExpensesForCurrentUser() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedExpenses =
            await ExpenseHandler().getExpensesByUserId(userId: user.id ?? '');
        expenses.assignAll(fetchedExpenses!);
        calculateTotalExpenseForCurrentMonth();
        findHighestExpense();
        if (highestExpense.value != null) {
          fetchCategoryDetails(highestExpense.value!.category);
        }
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

  void findHighestExpense() {
    if (expenses.isNotEmpty) {
      highestExpense.value = expenses.reduce((curr, next) =>
          curr.expenseAmount > next.expenseAmount ? curr : next);
    }
  }

  Future<void> fetchCategoryDetails(String categoryName) async {
    var expenseCategories = await CategoryPreferences.loadExpenseCategories();
    var selectedCategory = expenseCategories.firstWhere(
      (category) => category.name == categoryName,
      orElse: () => CategoryModel(
          name: 'UnCategorized',
          imagePath: "assets/images/fallback)image.png",
          backgroundColor: tealColor[20]!,
          foregroundColor: tealColor),
    );
    this.selectedCategory.value = selectedCategory;
  }
}
