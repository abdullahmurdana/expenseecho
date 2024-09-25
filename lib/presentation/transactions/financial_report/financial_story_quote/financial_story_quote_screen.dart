import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_quote/financial_story_quote_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class FinancialStoryQuoteScreen extends StatefulWidget {
  const FinancialStoryQuoteScreen({super.key});

  @override
  _FinancialStoryQuoteScreenState createState() =>
      _FinancialStoryQuoteScreenState();
}

class _FinancialStoryQuoteScreenState extends State<FinancialStoryQuoteScreen> {
  final controller = Get.find<FinancialStoryQuoteController>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingActionButton(size, localization),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: violetColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                120.h,
                Text(
                  localization.msg_quote,
                  style: AppStyle.poppinsBoldWhite(fontSize: 28),
                ),
                10.h,
                Text(
                  localization.msg_quote_by,
                  style: AppStyle.poppinsBoldWhite(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildFloatingActionButton(Size size, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: buildElevatedButton(
        height: 56,
        width: size.width,
        onTapped: () => Get.toNamed(AppRoutes.financialReportDetailsScreen),
        title: localization.lbl_see_full_details,
        fgColor: violetColor,
        bgColor: lightThemeColor,
        textStyle: AppStyle.poppinsCustom(
          fontSize: 20,
          color: violetColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
