import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/presentation/budgets/budget_details/budget_details_screen.dart';
import 'package:expenseecho/presentation/budgets/budget_list_view/budget_tile_controller.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BudgetTile extends StatelessWidget {
  final BudgetModel budgetModel;
  BudgetTile({super.key, required this.budgetModel}) {
    Get.put(
      BudgetTileController(budgetModel.category),
      tag: budgetModel.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final controller =
        Get.find<BudgetTileController>(tag: budgetModel.category);
    return Obx(() {
      if (controller.selectedCategory.value == null) {
        return Container(
          height: 90,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: lightThemeColor[80],
          ),
          child: const Center(
            child: CustomLoadingIndicator(),
          ),
        );
      }
      double progress = controller.totalExpenseForCurrentMonth.value /
          budgetModel.budgetAmount;
      int remaining = (budgetModel.budgetAmount -
              controller.totalExpenseForCurrentMonth.value)
          .toInt();
      return GestureDetector(
        onTap: () => Get.to(
          () => BudgetDetailsScreen(
            budgetModel: budgetModel,
            remaining: remaining,
            progress: progress,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(
              //   width: 1,
              //   color: lightThemeColor[20]!,
              // ),
              color: lightThemeColor),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: lightThemeColor[20]!,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller
                                  .selectedCategory.value!.foregroundColor,
                            ),
                          ),
                          10.w,
                          Text(
                            controller.selectedCategory.value!.name,
                            style: AppStyle.poppinsMediumBlack(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    remaining < 0
                        ? Image.asset("assets/icons/warning_icon_red.png")
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${localization.lbl_remaining} \$$remaining",
                      style: AppStyle.poppinsBoldBlack(fontSize: 20),
                    ),
                    LinearProgressIndicator(
                      minHeight: 18,
                      borderRadius: BorderRadius.circular(16),
                      value: progress,
                      backgroundColor: lightThemeColor[20],
                      color:
                          controller.selectedCategory.value?.foregroundColor ??
                              tealColor,
                    ),
                    Text(
                      '\$${controller.totalExpenseForCurrentMonth.value} of \$${budgetModel.budgetAmount}',
                      style: AppStyle.poppinsCustom(
                        fontSize: 16,
                        color: lightThemeColor[20]!,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    remaining < 0
                        ? Text(
                            localization.msg_limit_exceed,
                            style: AppStyle.poppinsCustom(
                              fontSize: 16,
                              color: redThemeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
