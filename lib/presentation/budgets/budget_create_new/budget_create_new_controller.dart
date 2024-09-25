import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/budget_db_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetCreateNewController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var existingBudgetModel = Rxn<BudgetModel>();
  var expenseAlert = false.obs;
  var alertPercentage = 0.obs;
  var amountController = TextEditingController().obs;
  var isLoading = false.obs;
  var connectivityResult = <ConnectivityResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    // Check internet connectivity
    connectivityResult.value = await Connectivity().checkConnectivity();
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryPreferences.loadExpenseCategories();
      print("---> Categories from SP :: ${fetchedCategories.length}");
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
        // print("---> Budget Create :: Fetch Categories successful");
      } else {
        Get.snackbar('Error', 'Failed to fetch Expense categories');
      }
    } catch (e) {
      print(
          "---> Budget Create :: Fetch Categories failed. :: ${e.toString()}");
      throw Exception("---> Budget Create :: Failed to load Categories...");
    }
  }

  Future<void> setExpenseAlert(bool value) async {
    expenseAlert.value = value;
    // await SharedPreferencesHandler.saveExpenseAlert(value);
  }

  Future<bool> createOrUpdateBudget(bool isEdit) async {
    try {
      isLoading.value = true;

      // Check if amount is valid
      int amount =
          double.parse(amountController.value.text.replaceAll('\$', ''))
              .toInt();
      if (amount <= 0) {
        Get.snackbar('Error', 'Invalid amount');
        return false;
      }

      // Check if user is logged in
      UserModel? user = await UserPreferences.getUserData();
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return false;
      }

      // Check if Category is selected
      if (selectedCategory.value == null) {
        Get.snackbar('Error', 'No Category selected');
        return false;
      }

      // Check if Receive Alert is selected
      if (expenseAlert.value && alertPercentage <= 0) {
        Get.snackbar('Error',
            'Change Alert Percentile on which you want to be alerted.');
        return false;
      }

      // Create budget model
      BudgetModel budgetModel = BudgetModel(
        userId: user.id ?? '',
        category: selectedCategory.value!.name,
        budgetAmount: amount,
        receiveAlert: expenseAlert.value,
        alertPercentile: expenseAlert.value ? alertPercentage.value : null,
      );

      // Add or update budget in local database
      if (isEdit) {
        await BudgetHandler().updateBudget(
          budget: budgetModel,
          budgetId: existingBudgetModel.value!.id ?? '',
        );
      } else {
        await BudgetHandler().insertBudget(budget: budgetModel);
      }

      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection, add budget to queue
        if (isEdit) {
          budgetModel = budgetModel.copyWith(id: existingBudgetModel.value?.id);
          await BudgetAPIService.addBudgetToQueue(budgetModel);
        } else {
          await BudgetAPIService.addBudgetToQueue(budgetModel);
        }
        Get.snackbar(
            'Success',
            isEdit
                ? 'Budget updated locally and added to queue'
                : 'Budget created locally and added to queue');
      } else {
        // Internet connection available, sync budget with server
        bool success;
        if (isEdit) {
          success = await BudgetAPIService.updateBudget(
            budgetModel: budgetModel,
            budgetId: existingBudgetModel.value!.id ?? '',
          );
        } else {
          success =
              await BudgetAPIService.createBudget(budgetModel: budgetModel);
        }

        if (!success) {
          Get.snackbar('Error',
              isEdit ? 'Failed to update budget' : 'Failed to create budget');
          return false;
        }

        Get.snackbar(
            'Success',
            isEdit
                ? 'Budget updated successfully'
                : 'Budget created successfully');
      }

      return true;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void initializeForEdit(BudgetModel budgetModel) {
    existingBudgetModel.value = budgetModel;
    selectedCategory.value = categories
        .firstWhere((category) => category.name == budgetModel.category);
    amountController.value.text = budgetModel.budgetAmount.toString();
    expenseAlert.value = budgetModel.receiveAlert ?? false;
    alertPercentage.value = budgetModel.alertPercentile ?? 0;
  }
}
