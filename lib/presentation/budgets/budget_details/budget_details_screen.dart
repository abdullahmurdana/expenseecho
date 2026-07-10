import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/presentation/budgets/budget_create_new/budget_create_new_screen.dart';
import 'package:expenseecho/presentation/budgets/budget_details/budget_details_controller.dart';
import 'package:expenseecho/widgets/custom_success_dialog.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class BudgetDetailsScreen extends StatefulWidget {
  final BudgetModel budgetModel;
  final int remaining;
  final double progress;
  const BudgetDetailsScreen({
    super.key,
    required this.budgetModel,
    required this.remaining,
    required this.progress,
  });

  @override
  _BudgetDetailsScreenState createState() => _BudgetDetailsScreenState();
}

class _BudgetDetailsScreenState extends State<BudgetDetailsScreen> {
  late BudgetModel budgetModel;
  CategoryModel? categoryModel;
  int remainingAmount = 0;
  double progress = 0.0;
  final budgetDetailsController = Get.find<BudgetDetailsController>();

  @override
  void initState() {
    budgetModel = widget.budgetModel;
    remainingAmount = widget.remaining;
    progress = widget.progress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    budgetDetailsController.fetchCategoryDetail(budgetModel.category);
    return Scaffold(
      appBar: buildAppBar(localization: localization, size: size),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingActionButton(size, localization),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: lightThemeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                45.h,
                // Category Details
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1,
                        color: lightThemeColor[40]!,
                      ),
                      color: lightThemeColor[80]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: budgetDetailsController.selectedCategory
                                      .value?.backgroundColor ??
                                  tealColor,
                            ),
                            child: Image.asset(budgetDetailsController
                                    .selectedCategory.value?.imagePath ??
                                'assets/images/fallback_image.png'),
                          );
                        }),
                        15.w,
                        Text(
                          budgetModel.category,
                          style: AppStyle.poppinsBoldBlack(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                32.h,
                // Budget Amount
                Column(
                  children: [
                    Text(
                      localization.lbl_remaining,
                      style: AppStyle.poppinsMediumBlack(fontSize: 24),
                    ),
                    Text(
                      '\$$remainingAmount',
                      style: AppStyle.poppinsBoldBlack(fontSize: 50),
                    ),
                  ],
                ),
                32.h,
                Obx(() {
                  return LinearProgressIndicator(
                    minHeight: 18,
                    borderRadius: BorderRadius.circular(16),
                    value: progress,
                    backgroundColor: lightThemeColor[20],
                    color: budgetDetailsController
                            .selectedCategory.value?.foregroundColor ??
                        tealColor,
                  );
                }),

                remainingAmount <= 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Container(
                          width: 220,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: redThemeColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/icons/warning_icon_light.png",
                                height: 32,
                                width: 32,
                              ),
                              Text(
                                localization.msg_limit_exceed,
                                style:
                                    AppStyle.poppinsMediumWhite(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
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
        onTapped: () => Get.to(
          () => BudgetCreateNewScreen(
            isEdit: true,
            budgetModel: budgetModel,
          ),
        ),
        title: localization.lbl_edit,
        bgColor: violetColor,
        fgColor: lightThemeColor,
        textStyle: AppStyle.poppinsRegularWhite(
          fontSize: 20,
        ),
      ),
    );
  }

  void showDeleteBottomSheet(BuildContext context,
      {required AppLocalizations localization, required Size size}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 220,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              10.h,
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkThemeColor[50],
                  ),
                ),
              ),
              15.h,
              Text(
                localization.lbl_remove_budget,
                style: AppStyle.poppinsCustom(
                  fontSize: 20,
                  color: darkThemeColor[100]!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              15.h,
              Text(
                localization.msg_remove_budget,
                textAlign: TextAlign.center,
                style: AppStyle.poppinsCustom(
                  fontSize: 16,
                  color: darkThemeColor[50]!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              25.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: violetColor[20]!,
                      fixedSize: Size((size.width / 2) - 30, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      localization.lbl_no,
                      style: AppStyle.poppinsCustom(
                          fontSize: 19,
                          color: violetColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      showSuccessDialog(
                          message: localization.msg_success_remove_budget);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: violetColor,
                      fixedSize: Size((size.width / 2) - 30, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      localization.lbl_yes,
                      style: AppStyle.poppinsCustom(
                          fontSize: 19,
                          color: lightThemeColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              15.h,
            ],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(
      {required AppLocalizations localization, required Size size}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: lightThemeColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () => showDeleteBottomSheet(context,
                size: size, localization: localization),
            child: Image.asset(
              "assets/icons/trash_icon_dark.png",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ],
      title: Text(
        localization.lbl_budget_detail,
        style: AppStyle.poppinsMediumBlack(fontSize: 20),
      ),
    );
  }
}
