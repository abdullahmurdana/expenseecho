import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/income_db_handler.dart';
import 'package:get/get.dart';

class FinancialStoryIncomeController extends GetxController {
  var income = <IncomeModel>[].obs;
  var totalIncomeForCurrentMonth = 0.0.obs;
  var highestIncome = Rxn<IncomeModel>();
  var selectedCategory = Rxn<CategoryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchIncomeListForCurrentUser();
  }

  Future<void> fetchIncomeListForCurrentUser() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedIncomes =
            await IncomeHandler().getIncomesByUserId(userId: user.id ?? '');
        income.assignAll(fetchedIncomes!);
        calculateTotalIncomeForCurrentMonth();
        findHighestincome();
        if (highestIncome.value != null) {
          fetchCategoryDetails(highestIncome.value!.category);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch incomes');
    }
  }

  void calculateTotalIncomeForCurrentMonth() {
    var now = DateTime.now();
    var currentMonthincomes = income.where((income) {
      // var incomeDate = DateTime.parse(income.createdAt ?? '');
      var incomeDate = income.createdAtDateTime!;
      return incomeDate.year == now.year && incomeDate.month == now.month;
    }).toList();

    totalIncomeForCurrentMonth.value =
        currentMonthincomes.fold(0.0, (sum, item) => sum + item.incomeAmount);
  }

  void findHighestincome() {
    if (income.isNotEmpty) {
      highestIncome.value = income.reduce(
          (curr, next) => curr.incomeAmount > next.incomeAmount ? curr : next);
    }
  }

  Future<void> fetchCategoryDetails(String categoryName) async {
    var expenseCategories = await CategoryPreferences.loadIncomeCategories();
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
