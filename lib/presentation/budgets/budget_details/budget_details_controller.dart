import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/services/shared_preferences/category_preferences.dart';
import 'package:get/get.dart';

class BudgetDetailsController extends GetxController {
  var selectedCategory = Rx<CategoryModel?>(null);
  var remainingAmount = 0.obs;
  var progress = 0.0.obs;

  Future<void> fetchCategoryDetail(String categoryName) async {
    var categories = <CategoryModel>[];
    var expenseCategories = await CategoryPreferences.loadExpenseCategories();

    categories = [...expenseCategories];

    var currentCategory = categories.firstWhere(
      (category) => categoryName == category.name,
    );

    selectedCategory.value = currentCategory;
  }

  void setBudgetDetails(int remaining, double progressValue) {
    remainingAmount.value = remaining;
    progress.value = progressValue;
  }
}
