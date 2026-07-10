import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/budgets/budget_create_new/budget_create_new_screen.dart';
import 'package:expenseecho/presentation/budgets/budget_list_view/budget_list_view_controller.dart';
import 'package:expenseecho/widgets/custom_budget_tile.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class BudgetListViewScreen extends StatefulWidget {
  const BudgetListViewScreen({super.key});

  @override
  _BudgetListViewScreenState createState() => _BudgetListViewScreenState();
}

class _BudgetListViewScreenState extends State<BudgetListViewScreen> {
  final budgetListViewController = Get.find<BudgetListViewController>();

  Future<void> _refreshBudgets() async {
    await budgetListViewController.getBudgets();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: violetColor,
          child: RefreshIndicator(
            onRefresh: _refreshBudgets,
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => budgetListViewController.changeMonth(-1),
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: lightThemeColor,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          budgetListViewController.selectedMonthName,
                          style: AppStyle.poppinsBoldWhite(fontSize: 18),
                        );
                      }),
                      GestureDetector(
                        onTap: () => budgetListViewController.changeMonth(1),
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: lightThemeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height * 0.75,
                    decoration: BoxDecoration(
                      color: lightThemeColor[80]!,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 45,
                      ),
                      child: Obx(() {
                        if (budgetListViewController.isLoading.value) {
                          return const Center(
                            child: CustomLoadingIndicator(),
                          );
                        }

                        var currentMonthBudgetList = budgetListViewController
                            .budgetsList
                            .where((budget) =>
                                budget.createdAtDateTime!.month ==
                                    budgetListViewController
                                        .selectedMonth.value.month &&
                                budget.createdAtDateTime!.year ==
                                    budgetListViewController
                                        .selectedMonth.value.year)
                            .toList();

                        if (currentMonthBudgetList.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                localization.msg_no_budget_yet,
                                textAlign: TextAlign.center,
                                style: AppStyle.poppinsCustom(
                                  fontSize: 16,
                                  color: lightThemeColor[20]!,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              buildElevatedButton(
                                height: 56,
                                width: size.width,
                                onTapped: () => Get.to(() =>
                                    const BudgetCreateNewScreen(isEdit: false)),
                                title: localization.lbl_create_a_budget,
                                bgColor: violetColor,
                                fgColor: lightThemeColor,
                              ),
                            ],
                          );
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: currentMonthBudgetList.length,
                                itemBuilder: (context, index) {
                                  var budget = currentMonthBudgetList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: BudgetTile(budgetModel: budget),
                                  );
                                },
                              ),
                            ),
                            buildElevatedButton(
                              height: 56,
                              width: size.width,
                              onTapped: () => Get.to(() =>
                                  const BudgetCreateNewScreen(isEdit: false)),
                              title: localization.lbl_create_a_budget,
                              bgColor: violetColor,
                              fgColor: lightThemeColor,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
