import 'dart:io';

import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/services/api_service_http.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class ExpenseAddNewController extends GetxController
    implements AttachmentController {
  var accounts = <AccountsModel>[].obs;
  var selectedAccount = Rxn<AccountsModel>();
  var categories = <CategoryModel>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var amountController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var attachment = Rx<File?>(null);
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
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
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch accounts');
      }
    }
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories =
          await SharedPreferencesHandler.loadExpenseCategories();
      if (fetchedCategories.isEmpty) {
        categories.assignAll(fetchedCategories);
      } else {
        Get.snackbar('Error', 'Failed to fetch Expense categories');
      }
    } catch (e) {
      throw Exception("---> Failed to load Categories...");
    }
  }
}
