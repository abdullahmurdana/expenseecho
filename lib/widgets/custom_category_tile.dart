import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/shared_preferences/category_preferences.dart';
import 'package:expenseecho/presentation/expenses/expense_details/expense_details_screen.dart';
import 'package:expenseecho/presentation/incomes/income_details/income_details_screen.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTile extends StatefulWidget {
  final dynamic transaction;
  final bool isExpense; // Add a flag to indicate if it's an expense
  final double totalAmount;

  const CategoryTile({
    super.key,
    required this.transaction,
    required this.isExpense,
    required this.totalAmount,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories(categoryName: widget.transaction.category).then((value) {
      setState(() {
        selectedCategory = value;
      });
    });
  }

  @override
  void didUpdateWidget(CategoryTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpense != widget.isExpense) {
      // Call _fetchCategories when the transaction type changes
      _fetchCategories(categoryName: widget.transaction.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategory == null) {
      return Container(
        height: 90,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: lightThemeColor[80],
        ),
        child: const Center(child: CustomLoadingIndicator()),
      );
    }

    double transactionAmount = widget.isExpense
        ? widget.transaction.expenseAmount
        : widget.transaction.incomeAmount;
    double progress = transactionAmount / widget.totalAmount;

    return GestureDetector(
      onTap: () {
        if (widget.transaction is ExpenseModel) {
          Get.to(() => ExpenseDetailsScreen(expenseModel: widget.transaction));
        } else if (widget.transaction is IncomeModel) {
          Get.to(() => IncomeDetailsScreen(incomeModel: widget.transaction));
        }
      },
      child: Container(
        height: 90,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: lightThemeColor[80],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedCategory?.foregroundColor ?? tealColor,
                        ),
                      ),
                      10.w,
                      Text(
                        widget.transaction.category,
                        style: AppStyle.poppinsBoldBlack(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  widget.transaction is ExpenseModel
                      ? Text(
                          '-${widget.transaction.expenseAmount}',
                          style: AppStyle.poppinsCustom(
                              fontSize: 18,
                              color: redThemeColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(
                          '+${widget.transaction.incomeAmount}',
                          style: AppStyle.poppinsCustom(
                              fontSize: 18,
                              color: greenThemeColor,
                              fontWeight: FontWeight.w600),
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: LinearProgressIndicator(
                  minHeight: 25,
                  borderRadius: BorderRadius.circular(16),
                  value: progress,
                  backgroundColor: lightThemeColor[20],
                  color: selectedCategory?.foregroundColor ?? tealColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<CategoryModel> _fetchCategories({required String categoryName}) async {
    var categories = <CategoryModel>[];
    var expenseCategories = await CategoryPreferences.loadExpenseCategories();
    var incomeCategories = await CategoryPreferences.loadIncomeCategories();

    categories = [...expenseCategories, ...incomeCategories];
    var currentCategory = categories.firstWhere((category) {
      return categoryName == category.name;
    });
    setState(() {
      selectedCategory = currentCategory;
    });
    return currentCategory;
  }
}
