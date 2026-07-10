import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var selectedTimeFrame = 'Today'.obs;
  var filteredExpenses = <ExpenseModel>[].obs;
  var filteredIncomes = <IncomeModel>[].obs;
  var expenses = <ExpenseModel>[].obs;
  var incomes = <IncomeModel>[].obs;
  var transfers = <TransfersModel>[].obs;
  var allTransactions = <dynamic>[].obs;
  var chartData = <FlSpot>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDummyData();
    fetchAllTransactions();
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
    await getExpenses();
    await getIncomeList();
    await fetchTransfers();
    await fetchAccounts();
    allTransactions.value = [...expenses, ...incomes, ...transfers];
    Future.delayed(
      const Duration(seconds: 2),
    );
    isLoading.value = false;
    return allTransactions;
  }

  Future<void> initializeDummyData() async {
    var dummyExpenses = await getExpenses();
    var dummyIncomes = await getIncomeList();

    filteredExpenses.value = dummyExpenses;
    filteredIncomes.value = dummyIncomes;
    updateChartData();
  }

  void filterData(String timeFrame) {
    selectedTimeFrame.value = timeFrame;

    List<ExpenseModel> expenseResult = [];
    List<IncomeModel> incomeResult = [];

    switch (timeFrame) {
      case 'Today':
        expenseResult =
            expenses.where((e) => e.createdAtDateTime!.isToday()).toList();
        incomeResult =
            incomes.where((i) => i.createdAtDateTime!.isToday()).toList();
        break;
      case 'Week':
        expenseResult =
            expenses.where((e) => e.createdAtDateTime!.isLastWeek()).toList();
        incomeResult =
            incomes.where((i) => i.createdAtDateTime!.isLastWeek()).toList();
        break;
      case 'Month':
        expenseResult =
            expenses.where((e) => e.createdAtDateTime!.isLastMonth()).toList();
        incomeResult =
            incomes.where((i) => i.createdAtDateTime!.isLastMonth()).toList();
        break;
      case 'Year':
        expenseResult =
            expenses.where((e) => e.createdAtDateTime!.isLastYear()).toList();
        incomeResult =
            incomes.where((i) => i.createdAtDateTime!.isLastYear()).toList();
        break;
    }

    filteredExpenses.value = expenseResult;
    filteredIncomes.value = incomeResult;
    updateChartData();
  }

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedExpenses =
            await ExpenseHandler().getExpensesByUserId(userId: user.id ?? '');
        print("---> Expenses Length :: Home :: ${fetchedExpenses!.length}");
        if (fetchedExpenses.isNotEmpty) {
          expenses.value = fetchedExpenses;
          return fetchedExpenses;
        }
      }

      return <ExpenseModel>[];
    } catch (e) {
      throw Exception('Failed to get expenses for user.');
    }
  }

  Future<List<IncomeModel>> getIncomeList() async {
    try {
      var user = await UserPreferences.getUserData();
      if (user != null) {
        var fetchedIncomes =
            await IncomeHandler().getIncomesByUserId(userId: user.id ?? '');
        print("---> Incomes Length :: Home :: ${fetchedIncomes!.length}");
        if (fetchedIncomes.isNotEmpty) {
          incomes.value = fetchedIncomes;
          return fetchedIncomes;
        }
      }

      return <IncomeModel>[];
    } catch (e) {
      throw Exception('Failed to get expenses for user.');
    }
  }

  void updateChartData() {
    List<FlSpot> spots = [];
    double cumulativeSum = 0;

    // Create a list to hold both expenses and incomes sorted by date
    List<Map<String, dynamic>> combinedData = [];

    for (var expense in filteredExpenses) {
      combinedData.add({
        'date': DateTime.parse(expense.createdAt ?? ''),
        'amount': -expense.expenseAmount, // Expenses reduce the total
      });
    }

    for (var income in filteredIncomes) {
      combinedData.add({
        'date': DateTime.parse(income.createdAt ?? ''),
        'amount': income.incomeAmount, // Incomes increase the total
      });
    }

    // Sort combined data by date
    combinedData.sort((a, b) => a['date'].compareTo(b['date']));

    // Generate the FlSpot list for the graph
    for (int i = 0; i < combinedData.length; i++) {
      cumulativeSum += combinedData[i]['amount'];
      spots.add(FlSpot(i.toDouble(), cumulativeSum));
    }

    chartData.value = spots;
  }
}
