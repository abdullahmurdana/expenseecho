import 'package:expenseecho/presentation/incomes/income_add_new/income_add_new_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/presentation/transfers/transfer_add_new/transfer_add_new_controller.dart';
import 'package:expenseecho/widgets/currency_input_formatter.dart';
import 'package:expenseecho/widgets/custom_dashed_border.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class TransferAddnewScreen extends StatefulWidget {
  const TransferAddnewScreen({super.key});

  @override
  _TransferAddnewScreenState createState() => _TransferAddnewScreenState();
}

class _TransferAddnewScreenState extends State<TransferAddnewScreen> {
  final addNewTransferScreenController = Get.find<TransferAddNewController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: blueThemeColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    const double horizontalPadding = 25.0;
    const double gap = 16.0;
    final double availableWidthWithoutGap =
        screenWidth - (2 * horizontalPadding) - gap;
    final double availableWidth = screenWidth - (2 * horizontalPadding);
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: blueThemeColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
        backgroundColor: blueThemeColor,
        centerTitle: true,
        title: Text(
          localization.lbl_transfer,
          style: AppStyle.poppinsCustom(
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
              final attachment =
                  addNewTransferScreenController.attachment.value;
              final bottomSheetHeight =
                  attachment != null ? size.height * 0.47 : size.height * 0.41;
              return Container(
                height: bottomSheetHeight, // Adjust height based on attachment
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    25.h,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => Container(
                                    width: availableWidthWithoutGap / 2,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: lightThemeColor[20]!,
                                        width: 1,
                                      ),
                                    ),
                                    child:
                                        DropdownButtonFormField<AccountsModel>(
                                      decoration: const InputDecoration(
                                        labelText: 'From',
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(18, 16, 12, 16),
                                        // helperText: addNewTransferScreenController
                                        //             .selectedFromAccount
                                        //             .value !=
                                        //         null
                                        //     ? 'Balance: \$${addNewTransferScreenController.selectedFromAccount.value!.balance}'
                                        //     : '',
                                      ),
                                      icon: const SizedBox.shrink(),
                                      items: addNewTransferScreenController
                                          .accounts
                                          .where((account) =>
                                              account !=
                                              addNewTransferScreenController
                                                  .selectedToAccount.value)
                                          .map((account) {
                                        return DropdownMenuItem<AccountsModel>(
                                          value: account,
                                          child: Text(account.name),
                                        );
                                      }).toList(),
                                      onChanged: (account) {
                                        addNewTransferScreenController
                                            .selectedFromAccount
                                            .value = account;
                                      },
                                      value: addNewTransferScreenController
                                          .selectedFromAccount.value,
                                    ),
                                  )),
                              gap.w,
                              Obx(() => Container(
                                    width: availableWidthWithoutGap / 2,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: lightThemeColor[20]!,
                                        width: 1,
                                      ),
                                    ),
                                    child:
                                        DropdownButtonFormField<AccountsModel>(
                                      decoration: const InputDecoration(
                                        labelText: 'To',
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(18, 16, 12, 16),
                                        // helperText: addNewTransferScreenController
                                        //             .selectedToAccount.value !=
                                        //         null
                                        //     ? 'Balance: \$${addNewTransferScreenController.selectedToAccount.value!.balance}'
                                        //     : '',
                                      ),
                                      icon: const SizedBox.shrink(),
                                      items: addNewTransferScreenController
                                          .accounts
                                          .where((account) =>
                                              account !=
                                              addNewTransferScreenController
                                                  .selectedFromAccount.value)
                                          .map((account) {
                                        return DropdownMenuItem<AccountsModel>(
                                          value: account,
                                          child: Text(account.name),
                                        );
                                      }).toList(),
                                      onChanged: (account) {
                                        addNewTransferScreenController
                                            .selectedToAccount.value = account;
                                      },
                                      value: addNewTransferScreenController
                                          .selectedToAccount.value,
                                    ),
                                  )),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: addNewTransferScreenController
                                  .validateAndSwitch,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: lightThemeColor[60]!,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/icons/transaction_icon.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    gap.h,
                    // Description TextField
                    Obx(() => buildTextField(
                          controller: addNewTransferScreenController
                              .descriptionController.value,
                          hintText: localization.lbl_enter_description,
                          labelText: localization.lbl_description,
                          height: 56,
                          width: availableWidth,
                        )),
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
                            showAttachmentBottomSheet(context,
                                size: size,
                                localization: localization,
                                controller:
                                    Get.find<TransferAddNewController>());
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
                                style: AppStyle.poppinsCustom(
                                  fontSize: 16,
                                  color: lightThemeColor[20]!,
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
                          addNewTransferScreenController.attachment.value;
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
                      child: Obx(
                        () {
                          final controller =
                              Get.find<TransferAddNewController>();
                          return buildElevatedButton(
                            height: 56,
                            width: size.width,
                            onTapped: () async {
                              // final attachment = controller.attachment.value;
                              // if (attachment != null) {
                              //   // await controller.uploadFileToS3(attachment);
                              // }
                              await controller.createTransfer().then((value) {
                                if (value) {
                                  Get.offAllNamed(AppRoutes.mainScreen);
                                }
                              });
                            },
                            title: localization.lbl_continue,
                            bgColor: blueThemeColor,
                            fgColor: lightThemeColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          // Amount Entry Section Above Bottom Sheet
          Positioned(
            bottom: addNewTransferScreenController.attachment.value != null
                ? size.height * 0.47
                : size.height * 0.41,
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
                      color: lightThemeColor[80]!,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() => SizedBox(
                        width: 200,
                        child: TextField(
                          controller: addNewTransferScreenController
                              .amountController.value,
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
                      )),
                ],
              ),
            ),
          ),
          Obx(() {
            final controller = Get.find<IncomeAddNewController>();
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
