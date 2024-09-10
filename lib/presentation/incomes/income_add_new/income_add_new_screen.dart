import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:expenseecho/widgets/currency_input_formatter.dart';
import 'package:expenseecho/widgets/custom_dashed_border.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/incomes/income_add_new/income_add_new_controller.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class IncomeAddNewScreen extends StatefulWidget {
  const IncomeAddNewScreen({super.key});

  @override
  _IncomeAddNewScreenState createState() => _IncomeAddNewScreenState();
}

class _IncomeAddNewScreenState extends State<IncomeAddNewScreen> {
  final incomeAddNewController = Get.find<IncomeAddNewController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: greenThemeColor,
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
      backgroundColor: greenThemeColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: lightThemeColor,
        ),
        backgroundColor: greenThemeColor,
        centerTitle: true,
        title: Text(
          localization.lbl_income,
          style: AppStyle.poppinsCustom(
            fontSize: 20,
            color: lightThemeColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              final attachment = incomeAddNewController.attachment.value;
              final isRepeat = incomeAddNewController.isRepeat;
              double bottomSheetHeight = size.height * 0.53;

              if (attachment != null) {
                bottomSheetHeight += size.height * 0.06;
              }
              if (isRepeat) {
                bottomSheetHeight += size.height * 0.05;
              }
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 10, 12, 22),
                          ),
                          items:
                              incomeAddNewController.categories.map((category) {
                            return DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Text(
                                category.name,
                                style:
                                    AppStyle.poppinsRegularBlack(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (account) {
                            incomeAddNewController.selectedCategory.value =
                                account;
                          },
                          value: incomeAddNewController.selectedCategory.value,
                        ),
                      ),
                    ),
                    gap.h,
                    Obx(() => buildTextField(
                          controller: incomeAddNewController
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
                        child: DropdownButtonFormField<AccountsModel>(
                          decoration: InputDecoration(
                            labelText: localization.lbl_account,
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
                          items: incomeAddNewController.accounts.map((account) {
                            return DropdownMenuItem<AccountsModel>(
                              value: account,
                              child: Text(
                                account.name,
                                style:
                                    AppStyle.poppinsRegularBlack(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (account) {
                            incomeAddNewController.selectedAccount.value =
                                account;
                          },
                          value: incomeAddNewController.selectedAccount.value,
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
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            showAttachmentBottomSheet(
                              context,
                              size: size,
                              localization: localization,
                              controller: Get.find<IncomeAddNewController>(),
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
                                style: AppStyle.poppinsCustom(
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
                          incomeAddNewController.attachment.value;
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
                    Obx(() {
                      final controller = Get.find<IncomeAddNewController>();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: buildSwitchTile(
                          title: localization.lbl_repeat,
                          subtitle: localization.lbl_repeat_transaction,
                          value: controller.isRepeat,
                          onChanged: (value) {
                            if (value) {
                              showFrequencyBottomSheet(
                                  context, size, localization);
                            } else {
                              controller.setIsRepeat(false);
                            }
                          },
                        ),
                      );
                    }),
                    Obx(() {
                      if (incomeAddNewController.isRepeat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localization.lbl_frequency,
                                    style: AppStyle.poppinsMediumBlack(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${incomeAddNewController.selectedFrequency.value} - ${incomeAddNewController.fullMonthList[incomeAddNewController.shortMonthList.indexOf(incomeAddNewController.selectedMonth.value)]}, ${incomeAddNewController.selectedYear.value}',
                                    style: AppStyle.poppinsCustom(
                                      fontSize: 12,
                                      color: lightThemeColor[20]!,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localization.lbl_end_after,
                                    style: AppStyle.poppinsMediumBlack(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${incomeAddNewController.selectedEndDay.value} ${incomeAddNewController.fullMonthList[incomeAddNewController.shortMonthList.indexOf(incomeAddNewController.selectedEndMonth.value)]}, ${incomeAddNewController.selectedEndYear.value}',
                                    style: AppStyle.poppinsCustom(
                                      fontSize: 12,
                                      color: lightThemeColor[20]!,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () => showFrequencyBottomSheet(
                                    context, size, localization),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: violetColor[20],
                                  foregroundColor: violetColor,
                                ),
                                child: Text(
                                  localization.lbl_edit,
                                  style: AppStyle.poppinsCustom(
                                    fontSize: 15,
                                    color: violetColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    (gap).h,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding),
                      child: Obx(() {
                        final controller = Get.find<IncomeAddNewController>();
                        return buildElevatedButton(
                          height: 56,
                          width: size.width,
                          onTapped: () async {
                            // final attachment = controller.attachment.value;
                            // if (attachment != null) {
                            //    await controller.uploadFileToS3(attachment);
                            // }
                            await controller.createIncome().then((value) {
                              if (value) {
                                Get.offAllNamed(AppRoutes.mainScreen);
                              }
                            });
                          },
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
          Obx(() {
            final attachment = incomeAddNewController.attachment.value;
            final isRepeat = incomeAddNewController.isRepeat;
            double bottomSheetHeight = size.height * 0.53;

            if (attachment != null) {
              bottomSheetHeight += size.height * 0.06;
            }
            if (isRepeat) {
              bottomSheetHeight += size.height * 0.05;
            }
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
                              incomeAddNewController.amountController.value,
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

  void showFrequencyBottomSheet(
      BuildContext context, Size size, AppLocalizations localization) {
    final controller = Get.find<IncomeAddNewController>();
    final now = DateTime.now();

    double availableWidth = size.width - 32;

    print("---> Selected frequency :: ${controller.selectedFrequency.value}");

    Get.bottomSheet(
      Obx(
        () {
          return Container(
            height: controller.selectedFrequency.value != null
                ? size.height * 0.34
                : size.height * 0.12,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.selectedFrequency.value == null
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 10,
                          ),
                          child: Text(
                            localization.lbl_frequency,
                            style: AppStyle.poppinsCustom(
                              fontSize: 18,
                              color: darkThemeColor[100]!,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                  controller.selectedFrequency.value == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: SizedBox(
                            height: 56,
                            width: availableWidth,
                            child: buildStringListDropdown(
                              value: controller.selectedFrequency.value ??
                                  localization.lbl_select_frequency,
                              items: controller.frequencyList,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedFrequency.value = newValue;
                                  controller.selectedMonth.value =
                                      controller.shortMonthList[now.month - 1];
                                  controller.selectedYear.value =
                                      now.year.toString().substring(2);
                                  controller.selectedEndDay.value =
                                      now.day.toString();
                                  switch (newValue) {
                                    case 'Daily':
                                      DateTime endDate =
                                          now.add(const Duration(days: 1));
                                      controller.selectedEndMonth.value =
                                          controller.shortMonthList[
                                              endDate.month - 1];
                                      controller.selectedEndYear.value =
                                          endDate.year.toString().substring(2);
                                      controller.selectedEndDay.value =
                                          endDate.day.toString();
                                      break;
                                    case 'Weekly':
                                      DateTime endDate =
                                          now.add(const Duration(days: 7));
                                      controller.selectedEndMonth.value =
                                          controller.shortMonthList[
                                              endDate.month - 1];
                                      controller.selectedEndYear.value =
                                          endDate.year.toString().substring(2);
                                      controller.selectedEndDay.value =
                                          endDate.day.toString();
                                      break;
                                    case 'Monthly':
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[(now.month % 12)];
                                      controller.selectedEndYear.value =
                                          (now.month == 12
                                                  ? now.year + 1
                                                  : now.year)
                                              .toString()
                                              .substring(2);
                                      break;
                                    case 'Quarterly':
                                      int endMonthIndex = (now.month + 3) % 12;
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[endMonthIndex];
                                      controller.selectedEndYear.value =
                                          (endMonthIndex < now.month
                                                  ? now.year + 1
                                                  : now.year)
                                              .toString()
                                              .substring(2);
                                      break;
                                    case 'Yearly':
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[now.month - 1];
                                      controller.selectedEndYear.value =
                                          (now.year + 1)
                                              .toString()
                                              .substring(2);
                                      break;
                                    default:
                                      break;
                                  }
                                }
                              },
                              labelText: localization.lbl_frequency,
                              isEnabled: true,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildStringListDropdown(
                              labelText: localization.lbl_frequency,
                              value: controller.selectedFrequency.value ?? '',
                              items: controller.frequencyList,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedFrequency.value = newValue;
                                  controller.selectedMonth.value =
                                      controller.shortMonthList[now.month - 1];
                                  controller.selectedYear.value =
                                      now.year.toString().substring(2);
                                  controller.selectedEndDay.value =
                                      now.day.toString();

                                  switch (newValue) {
                                    case 'Daily':
                                      DateTime endDate =
                                          now.add(const Duration(days: 1));
                                      controller.selectedEndMonth.value =
                                          controller.shortMonthList[
                                              endDate.month - 1];
                                      controller.selectedEndYear.value =
                                          endDate.year.toString().substring(2);
                                      controller.selectedEndDay.value =
                                          endDate.day.toString();
                                      break;
                                    case 'Weekly':
                                      DateTime endDate =
                                          now.add(const Duration(days: 7));
                                      controller.selectedEndMonth.value =
                                          controller.shortMonthList[
                                              endDate.month - 1];
                                      controller.selectedEndYear.value =
                                          endDate.year.toString().substring(2);
                                      controller.selectedEndDay.value =
                                          endDate.day.toString();
                                      break;
                                    case 'Monthly':
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[(now.month % 12)];
                                      controller.selectedEndYear.value =
                                          (now.month == 12
                                                  ? now.year + 1
                                                  : now.year)
                                              .toString()
                                              .substring(2);
                                      break;
                                    case 'Quarterly':
                                      int endMonthIndex = (now.month + 3) % 12;
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[endMonthIndex];
                                      controller.selectedEndYear.value =
                                          (endMonthIndex < now.month
                                                  ? now.year + 1
                                                  : now.year)
                                              .toString()
                                              .substring(2);
                                      break;
                                    case 'Yearly':
                                      controller.selectedEndMonth.value =
                                          controller
                                              .shortMonthList[now.month - 1];
                                      controller.selectedEndYear.value =
                                          (now.year + 1)
                                              .toString()
                                              .substring(2);
                                      break;
                                    default:
                                      break;
                                  }
                                }
                              },
                              isEnabled: true,
                            ),
                            7.w,
                            buildStringListDropdown(
                                labelText: localization.lbl_start_month,
                                value: controller.selectedMonth.value,
                                items: controller.shortMonthList,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    controller.selectedMonth.value = newValue;
                                  }
                                },
                                isEnabled: false),
                            7.w,
                            buildStringListDropdown(
                                labelText: localization.lbl_start_year,
                                value: controller.selectedYear.value,
                                items: [controller.selectedYear.value],
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    controller.selectedEndDay.value = newValue;
                                  }
                                },
                                isEnabled: false),
                          ],
                        ),
                  controller.selectedFrequency.value == null
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            localization.lbl_end_after,
                            style: AppStyle.poppinsCustom(
                              fontSize: 18,
                              color: darkThemeColor[100]!,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                  controller.selectedFrequency.value == null
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildStringListDropdown(
                              labelText: localization.lbl_end_day,
                              value: controller.selectedEndDay.value,
                              items: controller.dayList,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedEndDay.value = newValue;
                                }
                              },
                              isEnabled: true,
                            ),
                            7.w,
                            buildStringListDropdown(
                              labelText: localization.lbl_end_month,
                              value: controller.selectedEndMonth.value,
                              items: controller.shortMonthList,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedEndMonth.value = newValue;
                                }
                              },
                              isEnabled: true,
                            ),
                            7.w,
                            buildStringListDropdown(
                              labelText: localization.lbl_end_year,
                              value: controller.selectedEndYear.value,
                              items: [controller.selectedEndYear.value],
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedEndYear.value = newValue;
                                }
                              },
                              isEnabled: true,
                            ),
                          ],
                        ),
                  16.h,
                  controller.selectedFrequency.value != null
                      ? Center(
                          child: buildElevatedButton(
                            height: 56,
                            width: availableWidth,
                            onTapped: () {
                              controller.setIsRepeat(true);
                              Get.back();
                            },
                            title: localization.lbl_continue,
                            bgColor: violetColor,
                            fgColor: lightThemeColor,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
