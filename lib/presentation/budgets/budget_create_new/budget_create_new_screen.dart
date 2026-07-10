import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/presentation/budgets/budget_create_new/budget_create_new_controller.dart';
import 'package:expenseecho/presentation/budgets/budget_list_view/budget_list_view_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:expenseecho/widgets/currency_input_formatter.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BudgetCreateNewScreen extends StatefulWidget {
  final bool isEdit;
  final BudgetModel? budgetModel;

  const BudgetCreateNewScreen(
      {super.key, required this.isEdit, this.budgetModel});

  @override
  _BudgetCreateNewScreenState createState() => _BudgetCreateNewScreenState();
}

class _BudgetCreateNewScreenState extends State<BudgetCreateNewScreen> {
  final budgetCreateNewController = Get.find<BudgetCreateNewController>();
  final budgetListViewController = Get.find<BudgetListViewController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: violetColor,
      statusBarIconBrightness: Brightness.light,
    ));
    print('---> Budget Model :: ${widget.budgetModel.toString()}');
    print('---> isEdit :: ${widget.isEdit}');
    if (widget.isEdit && widget.budgetModel != null) {
      budgetCreateNewController.fetchCategories().then((_) {
        budgetCreateNewController.initializeForEdit(widget.budgetModel!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: violetColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
        title: Text(
          widget.isEdit
              ? localization.lbl_edit_budget
              : localization.lbl_create_budget,
          style: AppStyle.poppinsMediumWhite(fontSize: 20),
        ),
      ),
      backgroundColor: violetColor,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  final isAlert = budgetCreateNewController.expenseAlert.value;
                  double bottomSheetHeight = size.height * 0.34;

                  if (isAlert) {
                    bottomSheetHeight += size.height * 0.06;
                  }

                  return Container(
                    height: bottomSheetHeight,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: lightThemeColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        buildCategoryDropdown(size, localization),
                        16.h,
                        _buildSwitchTile(localization: localization),
                        16.h,
                        _buildPercentageSlider(),
                        24.h,
                        buildElevatedButton(
                          height: 56,
                          width: size.width,
                          onTapped: () async {
                            await budgetCreateNewController
                                .createOrUpdateBudget(widget.isEdit)
                                .then((value) async {
                              if (value) {
                                Get.snackbar(
                                  'Success',
                                  widget.isEdit
                                      ? localization.msg_success_update_budget
                                      : localization.msg_success_create_budget,
                                );
                              }
                              // Delay to ensure snackbar is shown
                              await Future.delayed(const Duration(seconds: 2));

                              await budgetListViewController.getBudgets();

                              // Navigate back to the list view screen
                              Get.until((route) =>
                                  Get.currentRoute ==
                                  AppRoutes.mainScreenBudgets);
                            });
                          },
                          title: localization.lbl_continue,
                          bgColor: violetColor,
                          fgColor: lightThemeColor,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              // Amount Entry Section Above Bottom Sheet
              Obx(() {
                final isAlert = budgetCreateNewController.expenseAlert.value;
                double bottomSheetHeight = size.height * 0.34;

                if (isAlert) {
                  bottomSheetHeight += size.height * 0.06;
                }
                return Positioned(
                  bottom: bottomSheetHeight,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.lbl_how_much_spend,
                          style: AppStyle.poppinsCustom(
                            fontSize: 18,
                            color: lightThemeColor[40]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(
                          () => SizedBox(
                            width: 200,
                            child: TextField(
                              controller: budgetCreateNewController
                                  .amountController.value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '\$0',
                                hintStyle:
                                    AppStyle.poppinsBoldWhite(fontSize: 50),
                              ),
                              style: AppStyle.poppinsBoldWhite(fontSize: 50),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyInputFormatter(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              // Custom Loading indicator
              Obx(() {
                return budgetCreateNewController.isLoading.value
                    ? const Positioned.fill(
                        child: BlurredBackground(
                          child: CustomLoadingIndicator(),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Obx buildCategoryDropdown(Size size, AppLocalizations localization) {
    return Obx(
      () => Container(
        width: size.width,
        height: 56,
        child: DropdownButtonFormField<CategoryModel>(
          decoration: InputDecoration(
            labelText: localization.lbl_category,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: lightThemeColor[20]!,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 12, 22),
          ),
          items: budgetCreateNewController.categories.map((category) {
            return DropdownMenuItem<CategoryModel>(
              value: category,
              child: Text(
                category.name,
                style: AppStyle.poppinsRegularBlack(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (account) {
            budgetCreateNewController.selectedCategory.value = account;
          },
          value: budgetCreateNewController.selectedCategory.value,
        ),
      ),
    );
  }

  Widget _buildPercentageSlider() {
    return Obx(
      () => budgetCreateNewController.expenseAlert.value
          ? SfSliderTheme(
              data: const SfSliderThemeData(
                thumbRadius: 18,
              ),
              child: SfSlider(
                min: 0,
                max: 100,
                value: budgetCreateNewController.alertPercentage.value,
                interval: 10,
                stepSize: 5,
                activeColor: violetColor,
                thumbIcon: Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: violetColor,
                  ),
                  child: Center(
                    child: Text(
                      '${budgetCreateNewController.alertPercentage.value.toInt()}',
                      style: AppStyle.poppinsMediumWhite(fontSize: 12),
                    ),
                  ),
                ),
                showDividers: true,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  budgetCreateNewController.alertPercentage.value = value;
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSwitchTile({
    required AppLocalizations localization,
  }) {
    return Obx(() {
      final controller = Get.find<BudgetCreateNewController>();
      return SwitchListTile(
        title: Text(
          localization.msg_receive_alert,
          style: AppStyle.poppinsCustom(
            fontSize: 15,
            color: darkThemeColor[100]!,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          localization.msg_receive_alert_reach,
          style: AppStyle.poppinsCustom(
            fontSize: 13,
            color: darkThemeColor[25]!,
            fontWeight: FontWeight.w300,
          ),
        ),
        activeColor: lightThemeColor,
        activeTrackColor: violetColor,
        inactiveThumbColor: lightThemeColor,
        inactiveTrackColor: violetColor[20],
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return lightThemeColor; // Active thumb color
          }
          return violetColor; // Inactive thumb color
        }),
        value: controller.expenseAlert.value,
        onChanged: (value) => controller.setExpenseAlert(value),
      );
    });
  }
}
