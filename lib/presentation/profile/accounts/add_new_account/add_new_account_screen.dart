import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/presentation/profile/accounts/add_new_account/add_new_account_controller.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:expenseecho/widgets/currency_input_formatter.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class AddNewAccountScreen extends StatefulWidget {
  final AccountsModel? accountsModel;
  final bool isEdit;
  const AddNewAccountScreen(
      {this.accountsModel, required this.isEdit, super.key});

  @override
  State<AddNewAccountScreen> createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {
  final accountAddNewController = Get.find<AddNewAccountController>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.accountsModel != null) {
      accountAddNewController.initializeForEdit(widget.accountsModel!);
    }
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
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? localization.lbl_edit_account
              : localization.lbl_add_new_account,
          style: AppStyle.poppinsCustom(
              fontSize: 18,
              color: lightThemeColor,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: violetColor,
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
      ),
      backgroundColor: violetColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              double bottomSheetHeight = size.height * 0.34;
              return Container(
                height: bottomSheetHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    buildTextField(
                      controller: accountAddNewController.nameController.value,
                      hintText: localization.hint_enter_bank_name,
                      labelText: localization.lbl_name,
                      height: 56,
                      width: availableWidth,
                    ),
                    gap.h,
                    Obx(
                      () => Container(
                        width: availableWidth,
                        height: 56,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: localization.lbl_type,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              borderSide: BorderSide(
                                color: lightThemeColor[20]!,
                                width: 1,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 10, 12, 22),
                          ),
                          items: accountAddNewController.accountTypes
                              .map((account) {
                            return DropdownMenuItem<String>(
                              value: account,
                              child: Text(
                                account,
                                style:
                                    AppStyle.poppinsRegularBlack(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (account) {
                            accountAddNewController
                                .setSelectedAccountType(account);
                          },
                          value:
                              accountAddNewController.selectedAccountType.value,
                        ),
                      ),
                    ),
                    (gap * 2).h,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding),
                      child: buildElevatedButton(
                        height: 56,
                        width: size.width,
                        onTapped: () =>
                            accountAddNewController.saveAccount(widget.isEdit),
                        title: localization.lbl_continue,
                        bgColor: violetColor,
                        fgColor: lightThemeColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          Obx(() {
            double bottomSheetHeight = size.height * 0.34;
            return Positioned(
              bottom: bottomSheetHeight,
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
                      style: AppStyle.poppinsCustom(
                        fontSize: 20,
                        color: lightThemeColor[40]!,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: 200,
                        child: TextField(
                          controller:
                              accountAddNewController.amountController.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '\$0',
                            hintStyle: AppStyle.poppinsBoldWhite(fontSize: 50),
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
          Obx(() {
            final controller = Get.find<AddNewAccountController>();
            return controller.loading.value
                ? const Positioned.fill(
                    child: BlurredBackground(
                      child: CustomLoadingIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
