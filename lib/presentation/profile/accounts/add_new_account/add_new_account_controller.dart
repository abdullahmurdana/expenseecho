import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAccountController extends GetxController {
  final nameController = TextEditingController().obs;
  final amountController = TextEditingController().obs;
  final accountTypes = ['Bank', 'Wallet', 'Card'].obs;
  final selectedAccountType = 'Bank'.obs;
  final loading = false.obs;
  var connectivityResult = <ConnectivityResult>[].obs;

  final AccountHandler _accountHandler = AccountHandler();

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
  }

  void initializeForEdit(AccountsModel account) {
    nameController.value.text = account.name;
    amountController.value.text = account.balance.toString();
    selectedAccountType.value = account.type;
  }

  void setSelectedAccountType(String? type) {
    if (type != null) {
      selectedAccountType.value = type;
    }
  }

  void _checkConnectivity() async {
    // Check internet connectivity
    connectivityResult.value = await Connectivity().checkConnectivity();
  }

  Future<void> saveAccount(bool isEdit) async {
    loading.value = true;
    final account = AccountsModel(
      id: isEdit ? Get.arguments['accountId'] : null,
      name: nameController.value.text,
      type: selectedAccountType.value,
      balance:
          double.tryParse(amountController.value.text.replaceAll(',', '')) ??
              0.0,
      userId: Get.arguments['userId'],
    );

    await _accountHandler.insertAccount(account: account);
    if (connectivityResult == ConnectivityResult.none) {
      await AccountAPIService.addAccountToQueue(account);
    } else {
      bool success = await AccountAPIService.createAccount(account: account);

      if (!success) {
        await AccountAPIService.addAccountToQueue(account);
      }
    }

    loading.value = false;
    navigateAfterSave();
  }

  void navigateAfterSave() {
    if (Get.arguments['fromSignUp'] == true) {
      Get.offAllNamed(AppRoutes.signupSuccessScreen);
    } else {
      Get.back();
    }
  }
}
