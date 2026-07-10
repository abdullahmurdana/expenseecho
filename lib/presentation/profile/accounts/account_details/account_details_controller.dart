import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/expense_db_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/income_db_handler.dart';
import 'package:get/get.dart';

class AccountDetailsController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var expenses = <ExpenseModel>[].obs;
  var incomes = <IncomeModel>[].obs;
  var allTransactions = <dynamic>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var userModel = Rxn<UserModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchUserData();
  }

  fetchUserData() async {
    try {
      userModel.value = await UserPreferences.getUserData();
    } catch (e) {
      throw Exception('Failed to get User data :: account details :: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedExpenseCategories =
          await CategoryPreferences.loadExpenseCategories();
      var fetchedincomeCategories =
          await CategoryPreferences.loadIncomeCategories();

      if (fetchedExpenseCategories.isNotEmpty &&
          fetchedincomeCategories.isNotEmpty) {
        categories.value = [
          ...fetchedExpenseCategories,
          ...fetchedincomeCategories
        ];
        print("---> Categories from SP :: ${categories.length}");
      } else {
        Get.snackbar('Error', 'Failed to fetch Expense categories');
      }
    } catch (e) {
      print(
          "---> Account details :: Fetch Categories failed. :: ${e.toString()}");
      throw Exception("Account details :: Failed to load Categories...");
    }
  }

  Future<void> fetchExpensesAndIncomes(String accountId) async {
    try {
      var user = await UserPreferences.getUserData();

      if (user != null) {
        var fetchedExpenses =
            await ExpenseHandler().getExpensesByUserId(userId: user.id ?? '');
        var fetchedIncomes =
            await IncomeHandler().getIncomesByUserId(userId: user.id ?? '');

        expenses.value = fetchedExpenses!
            .where((expense) => expense.accountId == accountId)
            .toList();
        incomes.value = fetchedIncomes!
            .where((income) => income.accountId == accountId)
            .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch expenses and incomes');
    }
  }

  Future<List<dynamic>> fetchAllTransactions(String accountId) async {
    isLoading.value = true;
    await fetchExpensesAndIncomes(accountId);
    allTransactions.value = [...expenses, ...incomes];
    print(
        '---> Transaction List :: accounts details :: ${allTransactions.length}');
    Future.delayed(
      const Duration(seconds: 2),
    );
    isLoading.value = false;
    return allTransactions;
  }
}
