import 'dart:io';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/services/api_service_http.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class TransferAddNewController extends GetxController
    implements AttachmentController {
  var accounts = <AccountsModel>[].obs;
  var selectedFromAccount = Rxn<AccountsModel>();
  var selectedToAccount = Rxn<AccountsModel>();
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

  void switchAccounts() {
    var temp = selectedFromAccount.value;
    selectedFromAccount.value = selectedToAccount.value;
    selectedToAccount.value = temp;
  }

  void validateAndSwitch() {
    if (selectedFromAccount.value == null || selectedToAccount.value == null) {
      Get.snackbar('Error', 'Both From and To accounts must be selected');
    } else {
      switchAccounts();
    }
  }

  Future<bool> createTransfer() async {
    if (selectedFromAccount.value == null || selectedToAccount.value == null) {
      Get.snackbar('Error', 'Both From and To accounts must be selected');
      return false;
    }

    if (amountController.value.text.isEmpty ||
        descriptionController.value.text.isEmpty) {
      Get.snackbar('Error', 'Amount and Description must be provided');
      return false;
    }

    double amount =
        double.parse(amountController.value.text.replaceAll('\$', ''));
    if (selectedFromAccount.value!.balance < amount) {
      Get.snackbar('Error', 'Insufficient balance in the From account');
      return false;
    }

    UserModel? user = await SharedPreferencesHandler.getUserData();
    if (user != null) {
      loading.value = true;
      try {
        // Update the balances of the selected accounts
        selectedFromAccount.value!.balance -= amount;
        selectedToAccount.value!.balance += amount;

        // Call the API to create the transfer
        bool success = await ApiServiceHttp.createTransfer(
          userId: user.userId,
          fromAccountId: selectedFromAccount.value!.id,
          toAccountId: selectedToAccount.value!.id,
          description: descriptionController.value.text,
          amount: amount,
        );

        if (success) {
          // Optionally, update the accounts on the server or local storage
          await ApiServiceHttp.updateAccountBalance(
            accountId: selectedFromAccount.value!.id,
            newBalance: selectedFromAccount.value!.balance,
          );
          await ApiServiceHttp.updateAccountBalance(
            accountId: selectedToAccount.value!.id,
            newBalance: selectedToAccount.value!.balance,
          );

          Get.snackbar('Success', 'Transfer created successfully');
          return true;
        } else {
          Get.snackbar('Error', 'Failed to create transfer');
          return false;
        }
      } catch (e) {
        print(
            "---> Error: Add New transfer Controller :: Create transfer ::$e ");
        Get.snackbar('Error', 'Failed to create transfer: $e');
        return false;
      } finally {
        loading.value = false;
      }
    } else {
      return false;
    }
  }
}
