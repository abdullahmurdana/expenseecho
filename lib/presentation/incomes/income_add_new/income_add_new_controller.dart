import 'dart:io';

import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/api_service_http.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class IncomeAddNewController extends GetxController
    implements AttachmentController {
  var accounts = <AccountsModel>[].obs;
  var selectedAccount = Rxn<AccountsModel>();
  var categories = <CategoryModel>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var amountController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var titleController = TextEditingController().obs;
  var attachment = Rx<File?>(null);
  var loading = false.obs;

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
    fetchAccounts();
    fetchCategories();
    initializeLocalizedLists();
  }

  @override
  void setAttachment(File file) {
    attachment.value = file;
  }

  Future<void> fetchAccounts() async {
    UserModel? user = await SharedPreferencesHandler.getUserData();
    if (user != null) {
      try {
        var fetchedAccounts =
            await ApiServiceHttp.fetchAccountsByUserID(userId: user.userId);
        accounts.assignAll(fetchedAccounts);
        print("---> I-N-C :: Fetch Accounts successfull");
      } catch (e) {
        print("---> Error :: Fetch Accounts (I-N-C) :: ${e.toString()}");
        Get.snackbar('Error', 'Failed to fetch accounts');
      }
    }
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories =
          await SharedPreferencesHandler.loadIncomeCategories();
      print("---> Categories from SP :: ${fetchedCategories.length}");
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
        // print("---> I-N-C :: Fetch Categories successful");
      } else {
        Get.snackbar('Error', 'Failed to fetch income categories');
      }
    } catch (e) {
      print("---> I-N-C :: Fetch Categories failed. :: ${e.toString()}");
      throw Exception("---> I-N-C :: Failed to load Categories...");
    }
  }

  Future<bool> createIncome() async {
    loading.value = true;
    update();

    try {
      // Check if user is logged in
      UserModel? user = await SharedPreferencesHandler.getUserData();
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

      // Create income model
      IncomeModel income = IncomeModel(
        userId: user.userId,
        accountId: selectedAccount.value!.id,
        category: selectedCategory.value?.name ?? 'Uncategorized',
        description: descriptionController.value.text,
        title: titleController.value.text,
        incomeAmount: amount,
        repeated: isRepeat,
        frequency: isRepeat ? selectedFrequency.value : null,
        startDate: isRepeat ? DateTime.now().format() : null,
        endAfterDate: isRepeat
            ? DateTime(
                int.parse('20${selectedEndYear.value}'),
                getMonthNumber(selectedEndMonth.value),
                int.parse(selectedEndDay.value),
              ).format()
            : null,
      );

      print('---> Income Data :: ${income.toString()}');

      // Add attachment link if attachment is not null
      if (attachment.value != null) {
        // String attachmentLink = await AttachmentHelper.uploadAttachment(attachment.value!);
        income = income.copyWith(attachmentLink: 'attachmentLink');
      }

      // Add income to backend
      bool success = await ApiServiceHttp.addIncome(income: income);
      if (!success) {
        Get.snackbar('Error', 'Failed to add income');
        return false;
      }

      // Update account balance
      double newBalance = selectedAccount.value!.balance - amount;
      bool balanceUpdated = await ApiServiceHttp.updateAccountBalance(
        accountId: selectedAccount.value!.id,
        newBalance: newBalance,
      );
      if (!balanceUpdated) {
        Get.snackbar('Error', 'Failed to update account balance');
        return false;
      }

      // Update local account balance
      selectedAccount.value =
          selectedAccount.value!.copyWith(balance: newBalance);

      Get.snackbar('Success', 'Income added successfully');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      return false;
    } finally {
      loading.value = false;
    }
  }
}
