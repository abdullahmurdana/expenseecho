import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_income/financial_story_income_controller.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class FinancialStoryIncomeScreen extends StatefulWidget {
  const FinancialStoryIncomeScreen({super.key});

  @override
  _FinancialStoryIncomeScreenState createState() =>
      _FinancialStoryIncomeScreenState();
}

class _FinancialStoryIncomeScreenState
    extends State<FinancialStoryIncomeScreen> {
  final controller = Get.find<FinancialStoryIncomeController>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: greenThemeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  localization.msg_this_month,
                  style: AppStyle.poppinsCustom(
                    fontSize: 28,
                    color: lightThemeColor[60]!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    localization.msg_you_earned,
                    style: AppStyle.poppinsBoldWhite(fontSize: 40),
                  ),
                  15.h,
                  Obx(() {
                    return Text(
                      '\$${controller.totalIncomeForCurrentMonth.value.toStringAsFixed(2)}',
                      style: AppStyle.poppinsBoldWhite(fontSize: 55),
                    );
                  }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  height: size.height * 0.28,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightThemeColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        localization.msg_biggest_earning,
                        style: AppStyle.poppinsMediumBlack(fontSize: 24),
                      ),
                      16.h,
                      Obx(() {
                        if (controller.highestIncome.value != null) {
                          var highestExpense = controller.highestIncome.value!;
                          return Column(
                            children: [
                              Container(
                                height: size.height * 0.08,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: lightThemeColor[20]!,
                                  ),
                                ),
                                child: Center(
                                  child: Obx(() {
                                    if (controller.selectedCategory.value !=
                                        null) {
                                      var selectedCategory =
                                          controller.selectedCategory.value!;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: selectedCategory
                                                  .backgroundColor,
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(
                                              selectedCategory.imagePath,
                                            ),
                                          ),
                                          10.w,
                                          Text(
                                            highestExpense.category,
                                            style: AppStyle.poppinsMediumBlack(
                                                fontSize: 18),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const CustomLoadingIndicator();
                                    }
                                  }),
                                ),
                              ),
                              16.h,
                              Text(
                                '\$${highestExpense.incomeAmount.toStringAsFixed(2)}',
                                style:
                                    AppStyle.poppinsMediumBlack(fontSize: 45),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            height: size.height * 0.08,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: lightThemeColor[20]!,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
