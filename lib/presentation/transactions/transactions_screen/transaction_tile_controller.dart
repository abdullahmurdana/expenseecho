import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/services/shared_preferences/category_preferences.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/account_db_handler.dart';
import 'package:get/get.dart';

class TransactionTileController extends GetxController {
  var selectedCategory = Rx<CategoryModel?>(null);
  var fromAccount = Rx<AccountsModel?>(null);
  var toAccount = Rx<AccountsModel?>(null);

  TransactionTileController(String categoryName) {
    if (categoryName.isNotEmpty) {
      fetchCategories(categoryName);
    }
  }

  Future<void> fetchCategories(String categoryName) async {
    var categories = <CategoryModel>[];
    var expenseCategories = await CategoryPreferences.loadExpenseCategories();
    var incomeCategories = await CategoryPreferences.loadIncomeCategories();

    categories = [...expenseCategories, ...incomeCategories];

    var currentCategory = categories.firstWhere(
      (category) => categoryName == category.name,
    );

    selectedCategory.value = currentCategory;
  }

  Future<void> fetchAccountData(
      String fromAccountId, String toAccountId) async {
    fromAccount.value =
        await AccountHandler().getAccountById(accountId: fromAccountId);
    // print(
    //     '---> From Account :: id-> $fromAccountId :: ${fromAccount.value.toString()}');

    toAccount.value =
        await AccountHandler().getAccountById(accountId: toAccountId);
    // print(
    //     '---> To Account :: id-> $toAccountId :: ${toAccount.value.toString()}');
  }
}
