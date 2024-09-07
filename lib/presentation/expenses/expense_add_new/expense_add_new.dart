import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/presentation/expenses/expense_add_new/expense_add_new_controller.dart';
import 'package:expenseecho/widgets/currency_input_formatter.dart';
import 'package:expenseecho/widgets/custom_dashed_border.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class ExpenseAddNewScreen extends StatefulWidget {
  const ExpenseAddNewScreen({super.key});

  @override
  _ExpenseAddNewScreenState createState() => _ExpenseAddNewScreenState();
}

class _ExpenseAddNewScreenState extends State<ExpenseAddNewScreen> {
  final expenseAddNewController = Get.find<ExpenseAddNewController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: redThemeColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    const double horizontalPadding = 25.0;
    const double gap = 16.0;
    final double availableWidth = screenWidth - (2 * horizontalPadding);
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: redThemeColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
        backgroundColor: redThemeColor,
        centerTitle: true,
        title: Text(
          localization.lbl_expense,
          style: AppStyle.gfPoppinsCustom(
            fontSize: 20,
            color: lightThemeColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              final attachment = expenseAddNewController.attachment.value;
              final bottomSheetHeight =
                  attachment != null ? size.height * 0.61 : size.height * 0.55;
              return Container(
                height: bottomSheetHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    24.h,
                    Obx(
                      () => Container(
                        width: availableWidth,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border:
                              Border.all(color: lightThemeColor[20]!, width: 1),
                        ),
                        child: DropdownButtonFormField<CategoryModel>(
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(18, 16, 12, 16),
                          ),
                          items: expenseAddNewController.categories
                              .map((category) {
                            return DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Text(category.name),
                            );
                          }).toList(),
                          onChanged: (account) {
                            expenseAddNewController.selectedCategory.value =
                                account;
                          },
                          value: expenseAddNewController.selectedCategory.value,
                        ),
                      ),
                    ),
                    gap.h,
                    Obx(() => buildTextField(
                          controller: expenseAddNewController
                              .descriptionController.value,
                          hintText: localization.lbl_enter_description,
                          labelText: localization.lbl_description,
                          height: 56,
                          width: availableWidth,
                        )),
                    gap.h,
                    Obx(
                      () => Container(
                        width: availableWidth,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border:
                              Border.all(color: lightThemeColor[20]!, width: 1),
                        ),
                        child: DropdownButtonFormField<AccountsModel>(
                          decoration: const InputDecoration(
                            labelText: 'Account',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(18, 16, 12, 16),
                          ),
                          items:
                              expenseAddNewController.accounts.map((account) {
                            return DropdownMenuItem<AccountsModel>(
                              value: account,
                              child: Text(account.name),
                            );
                          }).toList(),
                          onChanged: (account) {
                            expenseAddNewController.selectedAccount.value =
                                account;
                          },
                          value: expenseAddNewController.selectedAccount.value,
                        ),
                      ),
                    ),
                    gap.h,
                    SizedBox(
                      height: 56,
                      width: availableWidth,
                      child: DashedBorder(
                        borderRadius: BorderRadius.circular(16),
                        color: lightThemeColor[20]!,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none, // Remove the default border
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            showAttachmentBottomSheet(
                              context,
                              size: size,
                              localization: localization,
                              controller: Get.find<ExpenseAddNewController>(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/attachment_icon.png",
                                height: 30,
                                width: 30,
                              ),
                              Text(
                                localization.lbl_add_attachment,
                                style: AppStyle.gfPoppinsCustom(
                                  fontSize: 16,
                                  color: darkThemeColor[25]!,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      final attachment =
                          expenseAddNewController.attachment.value;
                      if (attachment != null) {
                        return SizedBox(
                          width: 120,
                          height: 120,
                          child: Column(
                            children: [
                              Image.file(attachment, width: 100, height: 100),
                              Text(attachment.path.split('/').last),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    (gap * 2).h,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding),
                      child: Obx(() {
                        final controller = Get.find<ExpenseAddNewController>();
                        return controller.loading.value
                            ? const CircularProgressIndicator()
                            : buildElevatedButton(
                                size: size,
                                onTapped: () {},
                                title: localization.lbl_continue,
                                bgColor: violetColor,
                                fgColor: lightThemeColor,
                              );
                      }),
                    ),
                  ],
                ),
              );
            }),
          ),
          // Amount Entry Section Above Bottom Sheet
          Positioned(
            bottom: expenseAddNewController.attachment.value != null
                ? size.height * 0.61
                : size.height * 0.55,
            left: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.lbl_how_much,
                    style: AppStyle.gfPoppinsCustom(
                      fontSize: 20,
                      color: lightThemeColor[40]!,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() => SizedBox(
                        width: 200,
                        child: TextField(
                          controller:
                              expenseAddNewController.amountController.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '\$0',
                            hintStyle:
                                AppStyle.gfPoppinsBoldWhite(fontSize: 50),
                          ),
                          style: AppStyle.gfPoppinsBoldWhite(fontSize: 50),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter(),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
