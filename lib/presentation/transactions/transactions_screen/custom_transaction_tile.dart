import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/presentation/transfers/transfer_details/transfer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/presentation/expenses/expense_details/expense_details_screen.dart';
import 'package:expenseecho/presentation/incomes/income_details/income_details_screen.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/transaction_tile_controller.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';

class TransactionTile extends StatelessWidget {
  final dynamic transaction;

  TransactionTile({super.key, required this.transaction}) {
    // Ensure each tile gets its own instance of the controller with a unique tag
    final controller = Get.put(
      TransactionTileController(
          transaction is TransfersModel ? '' : transaction.category),
      tag: transaction is TransfersModel ? '' : transaction.category,
    );

    // Fetch account data if the transaction is a TransfersModel
    if (transaction is TransfersModel) {
      controller.fetchAccountData(
          transaction.fromAccountId, transaction.toAccountId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionTileController>(
      tag: transaction is TransfersModel ? '' : transaction.category,
    );

    return Obx(() {
      if (controller.selectedCategory.value == null &&
          transaction is! TransfersModel) {
        return Container(
          height: 90,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: lightThemeColor[80],
          ),
          child: const Center(
            child: CustomLoadingIndicator(),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          if (transaction is ExpenseModel) {
            Get.to(() => ExpenseDetailsScreen(expenseModel: transaction));
          } else if (transaction is IncomeModel) {
            Get.to(() => IncomeDetailsScreen(incomeModel: transaction));
          } else if (transaction is TransfersModel) {
            Get.to(() => TransferDetailsScreen(transfersModel: transaction));
          }
        },
        child: Container(
          height: 90,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: lightThemeColor[80],
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: transaction is TransfersModel
                      ? Colors.grey
                      : controller.selectedCategory.value!.backgroundColor,
                ),
                child: transaction is TransfersModel
                    ? const Icon(Icons.swap_horiz, color: Colors.white)
                    : Image.asset(controller.selectedCategory.value!.imagePath),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transaction is TransfersModel
                                ? 'From : ${controller.fromAccount.value?.name}'
                                : transaction.category,
                            style: AppStyle.poppinsMediumBlack(
                              fontSize: 17,
                            ),
                          ),
                          transaction is ExpenseModel
                              ? Text(
                                  '-${transaction.expenseAmount}',
                                  style: AppStyle.poppinsCustom(
                                      fontSize: 18,
                                      color: redThemeColor,
                                      fontWeight: FontWeight.w600),
                                )
                              : transaction is IncomeModel
                                  ? Text(
                                      '+${transaction.incomeAmount}',
                                      style: AppStyle.poppinsCustom(
                                          fontSize: 18,
                                          color: greenThemeColor,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      '${transaction.amount}',
                                      style: AppStyle.poppinsCustom(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                        ],
                      ),
                      10.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transaction is TransfersModel
                                ? 'To : ${controller.toAccount.value?.name}'
                                : transaction.title,
                            style: AppStyle.poppinsCustom(
                              fontSize: 15,
                              color: lightThemeColor[20]!,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            DateTime.parse(transaction.createdAt)
                                .format(pattern: onlyTimeFormatPattern),
                            style: AppStyle.poppinsCustom(
                              fontSize: 16,
                              color: lightThemeColor[20]!,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
