import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class BudgetEmptyStateScreen extends StatefulWidget {
  const BudgetEmptyStateScreen({super.key});

  @override
  _BudgetEmptyStateScreenState createState() => _BudgetEmptyStateScreenState();
}

class _BudgetEmptyStateScreenState extends State<BudgetEmptyStateScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: violetColor,
      statusBarIconBrightness: Brightness.light,
    ));
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
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TODO Add method in controller for switching to previous month
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: lightThemeColor,
                        ),
                      ),
                      // TODO Add method in controller for showing the selected month / current month
                      Text(
                        localization.lbl_month_september,
                        style: AppStyle.poppinsBoldWhite(fontSize: 18),
                      ),
                      // TODO Add method in controller for switching to next month
                      GestureDetector(
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
                    decoration: const BoxDecoration(
                      color: lightThemeColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 45,
                      ),
                      child: Column(
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
                            onTapped: () =>
                                Get.toNamed(AppRoutes.budgetCreateNewScreen),
                            title: localization.lbl_create_a_budget,
                            bgColor: violetColor,
                            fgColor: lightThemeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
