import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final RxList<String> accountTypes = ["Bank", "Credit Card", "Wallet"].obs;
  final RxString _selectedAccountType =
      "Bank".obs; // Initialize with a default value

  String? get selectedAccountType => _selectedAccountType.value;

  void setSelectedAccountType(String? newValue) {
    if (newValue != null) {
      _selectedAccountType.value = newValue;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
