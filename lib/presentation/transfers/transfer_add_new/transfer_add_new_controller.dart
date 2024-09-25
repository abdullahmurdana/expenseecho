import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/attachment_helper.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferAddNewController extends GetxController
    implements AttachmentController {
  var accounts = <AccountsModel>[].obs;
  var existingTransferModel = Rxn<TransfersModel>();
  var selectedFromAccount = Rxn<AccountsModel>();
  var selectedToAccount = Rxn<AccountsModel>();
  var amountController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var attachment = Rx<File?>(null);
  var loading = false.obs;
  var connectivityResult = <ConnectivityResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
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
        var fetchedAccounts =
            await AccountHandler().getAccountsByUserId(userId: user.id ?? '');
        accounts.assignAll(fetchedAccounts!);
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

  Future<AccountsModel> fetchAccountsByID(String accountID) async {
    try {
      var fetchedAccount = await AccountHandler().getAccountById(
        accountId: accountID,
      );

      print("---> E-N-C :: Fetch Accounts successful");
      return fetchedAccount!;
    } catch (e) {
      throw Exception(
          "---> Error :: Fetch Accounts (T-N-C) :: ${e.toString()}");
    }
  }

  Future<void> initializeForEdit(TransfersModel transferModel) async {
    print('---> Initializing Transfer for Editing.');
    existingTransferModel.value = transferModel;
    amountController.value.text = transferModel.amount.toString();
    descriptionController.value.text = transferModel.description;
    selectedToAccount.value =
        await fetchAccountsByID(transferModel.toAccountId);
    selectedFromAccount.value =
        await fetchAccountsByID(transferModel.fromAccountId);
  }

  Future<bool> createOrUpdateTransfer(bool isEdit) async {
    loading.value = true;

    try {
      // Check if user is logged in
      UserModel? user = await UserPreferences.getUserData();
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return false;
      }

      // Check if both From and To accounts are selected
      if (selectedFromAccount.value == null ||
          selectedToAccount.value == null) {
        Get.snackbar('Error', 'Both From and To accounts must be selected');
        return false;
      }

      // Check if amount and description are provided
      if (amountController.value.text.isEmpty ||
          descriptionController.value.text.isEmpty) {
        Get.snackbar('Error', 'Amount and Description must be provided');
        return false;
      }

      // Check if amount is valid
      double amount =
          double.parse(amountController.value.text.replaceAll('\$', ''));
      if (amount <= 0) {
        Get.snackbar('Error', 'Invalid amount');
        return false;
      }

      // Check if From account has sufficient balance
      if (selectedFromAccount.value!.balance < amount) {
        Get.snackbar('Error', 'Insufficient balance in the From account');
        return false;
      }

      // Create transfer model
      TransfersModel transfer = existingTransferModel.value?.copyWith(
            userId: user.id ?? '',
            toAccountId: selectedToAccount.value?.id ?? 'No ID',
            fromAccountId: selectedFromAccount.value?.id ?? 'No ID',
            amount: amount,
            description: descriptionController.value.text,
          ) ??
          TransfersModel(
            userId: user.id ?? '',
            fromAccountId: selectedFromAccount.value?.id ?? 'No ID',
            toAccountId: selectedToAccount.value?.id ?? 'No ID',
            description: descriptionController.value.text,
            amount: amount,
          );

      print('---> Transfer Data :: ${transfer.toString()}');

      // Add or update transfer in local database
      if (isEdit) {
        await TransferHandler().updateTransfer(
          transfer: transfer,
          transferId: existingTransferModel.value!.id ?? '',
        );
      } else {
        await TransferHandler().insertTransfer(transfer: transfer);
      }

      // Update the balances of the selected accounts locally
      selectedFromAccount.value!.balance -= amount;
      selectedToAccount.value!.balance += amount;

      await AccountHandler().updateAccountBalance(
          accountId: selectedFromAccount.value?.id ?? '',
          newBalance: selectedFromAccount.value!.balance);
      await AccountHandler().updateAccountBalance(
          accountId: selectedToAccount.value?.id ?? '',
          newBalance: selectedToAccount.value!.balance);

      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection, add transfer and balance update to queue
        await TransferAPIService.addTransferToQueue(transfer);
        await AccountAPIService.addAccountToQueue(selectedFromAccount.value!);
        await AccountAPIService.addAccountToQueue(selectedToAccount.value!);
        Get.snackbar('Success', 'Transfer added to local database and queue');
      } else {
        // Internet connection available, sync transfer and balance update with server
        bool success = await TransferAPIService.createTransfer(
          userId: user.id ?? '',
          fromAccountId: selectedFromAccount.value?.id ?? 'No ID',
          toAccountId: selectedToAccount.value?.id ?? 'No ID',
          description: descriptionController.value.text,
          amount: amount,
        );

        if (!success) {
          // Add to queue if API call fails
          await TransferAPIService.addTransferToQueue(transfer);
          await AccountAPIService.addAccountToQueue(selectedFromAccount.value!);
          await AccountAPIService.addAccountToQueue(selectedToAccount.value!);
          print('---> Failed to create transfer, added to queue');
          Get.snackbar('Error', 'Failed to create transfer, added to queue');
          return false;
        }

        bool fromBalanceUpdated = await AccountAPIService.updateAccountBalance(
          accountId: selectedFromAccount.value?.id ?? 'No ID',
          newBalance: selectedFromAccount.value!.balance,
        );

        bool toBalanceUpdated = await AccountAPIService.updateAccountBalance(
          accountId: selectedToAccount.value?.id ?? 'No ID',
          newBalance: selectedToAccount.value!.balance,
        );

        if (!fromBalanceUpdated || !toBalanceUpdated) {
          // Add to queue if balance update fails
          await AccountAPIService.addAccountToQueue(selectedFromAccount.value!);
          await AccountAPIService.addAccountToQueue(selectedToAccount.value!);
          print('---> Failed to update account balances, added to queue');
          Get.snackbar(
              'Error', 'Failed to update account balances, added to queue');
          return false;
        }

        Get.snackbar(
            'Success',
            isEdit
                ? 'Transfer updated successfully'
                : 'Transfer created successfully');
      }

      return true;
    } catch (e) {
      print('---> Error while adding transfer(Controller): ${e.toString()}');
      return false;
    } finally {
      loading.value = false;
    }
  }
}
