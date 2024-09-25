import 'package:expenseecho/core/utils/app_styles.dart';
// import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_budget/financial_story_budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class FinancialStoryBudgetScreen extends StatefulWidget {
  const FinancialStoryBudgetScreen({super.key});

  @override
  _FinancialStoryBudgetScreenState createState() =>
      _FinancialStoryBudgetScreenState();
}

class _FinancialStoryBudgetScreenState
    extends State<FinancialStoryBudgetScreen> {
  final controller = Get.find<FinancialStoryBudgetController>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: violetColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    localization.msg_budget_story,
                    style: AppStyle.poppinsBoldWhite(fontSize: 40),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
