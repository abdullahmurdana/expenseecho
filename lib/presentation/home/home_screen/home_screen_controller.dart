import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expenseecho/data/services/api_service_http.dart';

class HomeScreenController extends GetxController {
  var selectedTimeFrame = 'Today'.obs;
  var filteredExpenses = <ExpenseModel>[].obs;
  var filteredIncomes = <IncomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeDummyData();
  }

  void initializeDummyData() {
    var dummyExpenses = <ExpenseModel>[];
    var dummyIncomes = <IncomeModel>[];

    filteredExpenses.value = dummyExpenses;
    filteredIncomes.value = dummyIncomes;
  }

  // Example method to filter data based on selected timeframe
  void filterData(String timeFrame, List<ExpenseModel> expenses,
      List<IncomeModel> incomes) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    List<ExpenseModel> expenseResult = [];
    List<IncomeModel> incomeResult = [];

    switch (timeFrame) {
      case 'Today':
        String todayDate = formatter.format(now);
        expenseResult =
            expenses.where((e) => e.createdAt!.startsWith(todayDate)).toList();
        incomeResult =
            incomes.where((i) => i.createdAt.startsWith(todayDate)).toList();
        break;
      case 'Week':
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        expenseResult = expenses
            .where(
                (e) => DateTime.parse(e.createdAt ?? '').isAfter(startOfWeek))
            .toList();
        incomeResult = incomes
            .where((i) => DateTime.parse(i.createdAt).isAfter(startOfWeek))
            .toList();
        break;
      case 'Month':
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        expenseResult = expenses
            .where(
                (e) => DateTime.parse(e.createdAt ?? '').isAfter(startOfMonth))
            .toList();
        incomeResult = incomes
            .where((i) => DateTime.parse(i.createdAt).isAfter(startOfMonth))
            .toList();
        break;
      case 'Year':
        DateTime startOfYear = DateTime(now.year, 1, 1);
        expenseResult = expenses
            .where(
                (e) => DateTime.parse(e.createdAt ?? '').isAfter(startOfYear))
            .toList();
        incomeResult = incomes
            .where((i) => DateTime.parse(i.createdAt).isAfter(startOfYear))
            .toList();
        break;
    }

    filteredExpenses.value = expenseResult;
    filteredIncomes.value = incomeResult;
  }

  Future<List<ExpenseModel>> getExpenses() async {
    var expenses = await ApiServiceHttp().fetchExpenses();
    print("---> Expenses Length :: Home :: ${expenses.length}");
    print("---> 1st Expense :: Home :: ${expenses.first.toString()}");
    return expenses;
  }

  Future<List<IncomeModel>> getIncomeList() async {
    var incomeList = await ApiServiceHttp().fetchIncomeList();
    print("---> Income List Length :: Home :: ${incomeList.length}");
    print("---> 1st Income List :: Home :: ${incomeList.first.toString()}");
    return incomeList;
  }
}
