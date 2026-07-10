import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/account_db_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/expense_db_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class ExpenseAddNewController extends GetxController
    implements AttachmentController {
  var accounts = <AccountsModel>[].obs;
  var selectedAccount = Rxn<AccountsModel>();
  var existingExpenseModel = Rxn<ExpenseModel>();
  var categories = <CategoryModel>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var amountController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var titleController = TextEditingController().obs;
  var attachment = Rx<File?>(null);
  var loading = false.obs;
  var connectivityResult = <ConnectivityResult>[].obs;

  var frequencyList = <String>[].obs;
  var fullMonthList = <String>[].obs;
  var shortMonthList = <String>[].obs;

  final _isRepeat = false.obs;
  bool get isRepeat => _isRepeat.value;
  setIsRepeat(bool newValue) {
    _isRepeat.value = newValue;
    if (!newValue) {
      // Reset frequency data when repeat is turned off
      selectedFrequency.value = null;
      selectedMonth.value = '';
      selectedYear.value = '';
      selectedEndDay.value = '';
      selectedEndMonth.value = '';
      selectedEndYear.value = '';
    }
  }

  void initializeLocalizedLists() {
    final localization = AppLocalizations.of(Get.context!)!;
    frequencyList.assignAll([
      localization.lbl_daily,
      localization.lbl_weekly,
      localization.lbl_monthly,
      localization.lbl_quarterly,
      localization.lbl_yearly,
    ]);

    fullMonthList.assignAll([
      localization.lbl_month_january,
      localization.lbl_month_february,
      localization.lbl_month_march,
      localization.lbl_month_april,
      localization.lbl_month_may,
      localization.lbl_month_june,
      localization.lbl_month_july,
      localization.lbl_month_august,
      localization.lbl_month_september,
      localization.lbl_month_october,
      localization.lbl_month_november,
      localization.lbl_month_december,
    ]);

    shortMonthList.assignAll([
      localization.lbl_short_month_jan,
      localization.lbl_short_month_feb,
      localization.lbl_short_month_mar,
      localization.lbl_short_month_apr,
      localization.lbl_short_month_may,
      localization.lbl_short_month_jun,
      localization.lbl_short_month_jul,
      localization.lbl_short_month_aug,
      localization.lbl_short_month_sep,
      localization.lbl_short_month_oct,
      localization.lbl_short_month_nov,
      localization.lbl_short_month_dec,
    ]);
  }

  var dayList = List.generate(31, (index) => (index + 1).toString());

  var selectedFrequency = Rxn<String>();
  var selectedMonth = ''.obs;
  var selectedYear = ''.obs;
  var selectedEndDay = ''.obs;
  var selectedEndMonth = ''.obs;
  var selectedEndYear = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLocalizedLists();
    });
    fetchAccounts();
    fetchCategories();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    // Check internet connectivity
    connectivityResult.value = await Connectivity().checkConnectivity();
  }

  @override
  void setAttachment(File file) {
    attachment.value = file;
  }

  Future<void> fetchAccounts() async {
    UserModel? user = await UserPreferences.getUserData();
    if (user != null) {
      try {
        var fetchedAccounts = await AccountHandler().getAccountsByUserId(
          userId: user.id ?? '',
        );
        accounts.assignAll(fetchedAccounts!);
        print("---> E-N-C :: Fetch Accounts successful");
      } catch (e) {
        print("---> Error :: Fetch Accounts (E-N-C) :: ${e.toString()}");
        Get.snackbar('Error', 'Failed to fetch accounts');
      }
    }
  }

  Future<AccountsModel> fetchAccountsByID(String accountID) async {
    try {
      var fetchedAccount = await AccountHandler().getAccountById(
        accountId: accountID,
      );

      print("---> E-N-C :: Fetch Accounts successful");
      return fetchedAccount!;
    } catch (e) {
      throw Exception(
          "---> Error :: Fetch Accounts (E-N-C) :: ${e.toString()}");
    }
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryPreferences.loadExpenseCategories();
      print("---> Categories from SP :: ${fetchedCategories.length}");
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
      } else {
        Get.snackbar('Error', 'Failed to fetch Expense categories');
      }
    } catch (e) {
      print("---> E-N-C :: Fetch Categories failed. :: ${e.toString()}");
      throw Exception("---> E-N-C :: Failed to load Categories...");
    }
  }

  Future<void> initializeForEdit(ExpenseModel expenseModel) async {
    print('---> Initializing Expense editing...');
    existingExpenseModel.value = expenseModel;
    selectedCategory.value = categories
        .firstWhere((category) => category.name == expenseModel.category);
    amountController.value.text = expenseModel.expenseAmount.toString();
    descriptionController.value.text = expenseModel.description;
    titleController.value.text = expenseModel.title;
    selectedAccount.value = await fetchAccountsByID(expenseModel.accountId);
    setIsRepeat(expenseModel.repeated);
    selectedFrequency.value = expenseModel.frequency;
    selectedMonth.value = expenseModel.startDateTime?.month.toString() ?? '';
    selectedYear.value = expenseModel.startDateTime?.year.toString() ?? '';
    selectedEndDay.value = expenseModel.endAfterDateTime?.day.toString() ?? '';
    selectedEndMonth.value =
        expenseModel.endAfterDateTime?.month.toString() ?? '';
    selectedEndYear.value =
        expenseModel.endAfterDateTime?.year.toString() ?? '';
  }

  Future<bool> createOrUpdateExpense({required bool isEdit}) async {
    try {
      loading.value = true;

      //* Delete previously added expenses.
      // await ExpenseHandler().deleteAllExpenses();
      // print('---> All Expenses => deleted.');

      // Check if user is logged in
      UserModel? user = await UserPreferences.getUserData();
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return false;
      }

      // Check if amount is valid
      double amount =
          double.parse(amountController.value.text.replaceAll('\$', ''));
      if (amount <= 0) {
        Get.snackbar('Error', 'Invalid amount');
        return false;
      }

      // Check if account is selected
      if (selectedAccount.value == null) {
        Get.snackbar('Error', 'No account selected');
        return false;
      }

      // Check if Category is selected
      if (selectedCategory.value == null) {
        Get.snackbar('Error', 'No Category selected');
        return false;
      }

      // Check if account has sufficient balance
      if (selectedAccount.value!.balance < amount) {
        Get.snackbar('Error', 'Insufficient account balance');
        return false;
      }

      // Create or update expense model
      ExpenseModel expense = existingExpenseModel.value?.copyWith(
            userId: user.id ?? '',
            accountId: selectedAccount.value?.id ?? 'No ID',
            category: selectedCategory.value?.name ?? 'Uncategorized',
            description: descriptionController.value.text,
            title: titleController.value.text,
            expenseAmount: amount,
            repeated: isRepeat,
            frequency: isRepeat ? selectedFrequency.value : null,
            startDate:
                isRepeat ? DateTime.now().format() : null, // Use format method
            endAfterDate: isRepeat
                ? DateTime(
                    int.parse('20${selectedEndYear.value}'),
                    getMonthNumber(selectedEndMonth.value),
                    int.parse(selectedEndDay.value),
                  ).format()
                : null, // Use format method
          ) ??
          ExpenseModel(
            userId: user.id ?? '',
            accountId: selectedAccount.value?.id ?? 'No ID',
            category: selectedCategory.value?.name ?? 'Uncategorized',
            description: descriptionController.value.text,
            title: titleController.value.text,
            expenseAmount: amount,
            repeated: isRepeat,
            frequency: isRepeat ? selectedFrequency.value : null,
            startDate:
                isRepeat ? DateTime.now().format() : null, // Use format method
            endAfterDate: isRepeat
                ? DateTime(
                    int.parse('20${selectedEndYear.value}'),
                    getMonthNumber(selectedEndMonth.value),
                    int.parse(selectedEndDay.value),
                  ).format()
                : null, // Use format method
          );

      print('---> Expense Data :: ${expense.toString()}');

      // Add attachment link if attachment is not null
      if (attachment.value != null) {
        // String attachmentLink = await AttachmentHelper.uploadAttachment(attachment.value!);
        expense = expense.copyWith(attachmentLink: 'attachmentLink');
      }

      // Add or update expense in local database
      if (isEdit) {
        await ExpenseHandler().updateExpense(
          expense: expense,
          expenseId: existingExpenseModel.value!.id ?? '',
        );
      } else {
        await ExpenseHandler().insertExpense(expense: expense);
      }

      // Update account balance locally
      double newBalance = selectedAccount.value!.balance - amount;
      await AccountHandler().updateAccountBalance(
        accountId: selectedAccount.value?.id ?? 'No ID',
        newBalance: newBalance,
      );

      // Update local account balance
      selectedAccount.value =
          selectedAccount.value!.copyWith(balance: newBalance);

      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection, add expense and balance update to queue
        await ExpenseAPIService.addExpenseToQueue(expense);
        await AccountAPIService.addAccountToQueue(selectedAccount.value!);
        Get.snackbar('Success', 'Expense added to local database and queue');
      } else {
        // Internet connection available, sync expense and balance update with server
        bool success = await ExpenseAPIService.addExpense(expense: expense);
        if (!success) {
          // Add to queue if API call fails
          await ExpenseAPIService.addExpenseToQueue(expense);
          Get.snackbar('Error', 'Failed to add expense, added to queue');
          return false;
        }

        bool balanceUpdated = await AccountAPIService.updateAccountBalance(
          accountId: selectedAccount.value?.id ?? 'No ID',
          newBalance: newBalance,
        );
        if (!balanceUpdated) {
          // Add to queue if API call fails
          await AccountAPIService.addAccountToQueue(selectedAccount.value!);
          Get.snackbar(
              'Error', 'Failed to update account balance, added to queue');
          return false;
        }
      }

      return true;
    } catch (e) {
      print('---> Error while adding expense: ${e.toString()}');
      return false;
    } finally {
      loading.value = false;
    }
  }
}
