import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:get/get.dart';

enum SortBy { highest, lowest, newest, oldest }

class TransactionsScreenController extends GetxController {
  var expenses = <ExpenseModel>[].obs;
  var incomes = <IncomeModel>[].obs;
  var transfers = <TransfersModel>[].obs;
  var allTransactions = <dynamic>[].obs;

  var isIncomeSelected = false.obs;
  var isExpenseSelected = false.obs;
  var sortBy = SortBy.newest.obs;
  var selectedCategory = ''.obs;
  var isLoading = false.obs;
  var filterCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllTransactions();
  }

  Future<void> fetchExpenses() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedExpenses =
            await ExpenseHandler().getExpensesByUserId(userId: user.id ?? '');
        // print('---> Expense Data :: ${fetchedExpenses.toString()}');
        expenses.assignAll(fetchedExpenses!);
        var fetchedAllExpenses = await ExpenseHandler().getExpenses();
        print('---> All Expense :: ${fetchedAllExpenses.length}');
        fetchedAllExpenses.toList().forEach((e) {
          print('---> Expense Model Map :  ${e.toMap()}');
        });
      }
    } catch (e) {
      print("---> Error fetching expenses: $e");
    }
  }

  Future<void> fetchIncomes() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedIncomes =
            await IncomeHandler().getIncomesByUserId(userId: user.id ?? '');
        // print('---> Income Data :: ${fetchedIncomes.toString()}');
        incomes.assignAll(fetchedIncomes!);
        var fetchedAllIncomes = await IncomeHandler().getIncomes();
        print('---> All Income :: ${fetchedAllIncomes.length}');
        fetchedAllIncomes.toList().forEach((e) {
          print('---> Income Model Map :  ${e.toMap()}');
        });
      }
    } catch (e) {
      print("---> Error fetching incomes: $e");
    }
  }

  Future<void> fetchTransfers() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedTransfers =
            await TransferHandler().getTransfersByUserId(userId: user.id ?? '');
        // print('---> Transfer Data :: ${fetchedTransfers.toString()}');
        /* var fetchedAllTransfers = await TransferHandler().getTransfers();
        print('---> All Transfer :: ${fetchedAllTransfers.length}');
        fetchedAllTransfers.toList().forEach((e) {
          print('---> Transfer Model Map :  ${e.toMap()}');
        }); */
        transfers.assignAll(fetchedTransfers!);
      }
    } catch (e) {
      print("---> Error fetching transfers: $e");
    }
  }

  Future<void> fetchAccounts() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedAccounts =
            await AccountHandler().getAccountsByUserId(userId: user.id ?? '');
        // print('---> Transfer Data :: ${fetchedTransfers.toString()}');
        /* var fetchedAllTransfers = await TransferHandler().getTransfers();*/
        print('---> All Accounts :: ${fetchedAccounts!.length}');
        fetchedAccounts.toList().forEach((e) {
          print('---> Accounts Model Map :  ${e.toMap()}');
        });
        // transfers.assignAll(fetchedTransfers!);
      }
    } catch (e) {
      print("---> Error fetching transfers: $e");
    }
  }

  Future<List<dynamic>> fetchAllTransactions() async {
    isLoading.value = true;
    await fetchExpenses();
    await fetchIncomes();
    await fetchTransfers();
    await fetchAccounts();
    allTransactions.value = [...expenses, ...incomes, ...transfers];
    Future.delayed(
      const Duration(seconds: 2),
    );
    isLoading.value = false;
    return allTransactions;
  }

  void toggleIncomeFilter(bool selected) {
    isIncomeSelected.value = selected;
  }

  void toggleExpenseFilter(bool selected) {
    isExpenseSelected.value = selected;
  }

  void setSortBy(SortBy sortOption) {
    sortBy.value = sortOption;
  }

  void resetFilters() {
    isIncomeSelected.value = false;
    isExpenseSelected.value = false;
    sortBy.value = SortBy.newest;
    selectedCategory.value = '';
    updateFilterCount();
  }

  void applyFilters() {
    isLoading.value = true;
    List<dynamic> filteredTransactions = allTransactions;

    if (isIncomeSelected.value) {
      filteredTransactions =
          filteredTransactions.whereType<IncomeModel>().toList();
    }

    if (isExpenseSelected.value) {
      filteredTransactions =
          filteredTransactions.whereType<ExpenseModel>().toList();
    }

    switch (sortBy.value) {
      case SortBy.highest:
        filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortBy.lowest:
        filteredTransactions.sort((a, b) => a.amount.compareTo(b.amount));
        break;
      case SortBy.newest:
        filteredTransactions.sort((a, b) =>
            DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
        break;
      case SortBy.oldest:
        filteredTransactions.sort((a, b) =>
            DateTime.parse(a.createdAt).compareTo(DateTime.parse(b.createdAt)));
        break;
    }

    allTransactions.value = filteredTransactions;
    updateFilterCount();
    Future.delayed(
      const Duration(seconds: 2),
    );
    isLoading.value = false;
  }

  void updateFilterCount() {
    int count = 0;
    if (isIncomeSelected.value) count++;
    if (isExpenseSelected.value) count++;
    if (sortBy.value != SortBy.newest) count++;
    if (selectedCategory.value.isNotEmpty) count++;
    filterCount.value = count;
  }
}
