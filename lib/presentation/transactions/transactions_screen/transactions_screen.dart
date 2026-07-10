import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/date_time_utils.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/transactions_screen_controller.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/custom_transaction_tile.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final transactionsScreenController = Get.find<TransactionsScreenController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightThemeColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    // debugPrint('---> Init Method :: Transaction screen ::');
  }

  Future<void> _refreshTransactions() async {
    await transactionsScreenController.fetchAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightThemeColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RefreshIndicator(
              onRefresh: _refreshTransactions,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.h,
                    // TODO add children => Filter Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            // color: lightThemeColor[20]!,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: lightThemeColor[20]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/arrow_down_violet.png"),
                              Text(
                                "Month",
                                style: AppStyle.poppinsMediumBlack(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showFilterBottomSheet(context,
                                localization: localization, size: size);
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  // color: lightThemeColor[20]!,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: lightThemeColor[20]!,
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.filter_list,
                                  size: 25,
                                  color: darkThemeColor,
                                ),
                              ),
                              Obx(() {
                                int filterCount = transactionsScreenController
                                    .filterCount.value;
                                if (filterCount > 0) {
                                  return Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 20,
                                        minHeight: 20,
                                      ),
                                      child: Text(
                                        '$filterCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.h,
                    // TODO add OnTap with gestureDetector => See Financial report Button
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.financialStoryScreen),
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: violetColor[20],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localization.lbl_see_financial_report,
                                style: AppStyle.poppinsCustom(
                                    fontSize: 18,
                                    color: violetColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 25,
                                color: violetColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.h,
                    Obx(() {
                      if (transactionsScreenController.isLoading.value) {
                        return const Center(
                          child: CustomLoadingIndicator(),
                        );
                      }

                      if (transactionsScreenController
                          .allTransactions.isEmpty) {
                        return const Center(
                          child: Text('No transactions yet'),
                        );
                      }

                      var todayTransactions = transactionsScreenController
                          .allTransactions
                          .where((transaction) =>
                              DateTime.parse(transaction.createdAt).isToday())
                          .toList();
                      var yesterdayTransactions = transactionsScreenController
                          .allTransactions
                          .where((transaction) =>
                              DateTime.parse(transaction.createdAt)
                                  .isYesterday())
                          .toList();
                      var lastWeekTransactions = transactionsScreenController
                          .allTransactions
                          .where((transaction) =>
                              DateTime.parse(transaction.createdAt)
                                  .isLastWeek())
                          .toList();

                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          if (todayTransactions.isNotEmpty) ...[
                            Text(
                              'Today',
                              style: AppStyle.poppinsBoldBlack(fontSize: 20),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: todayTransactions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var transaction = todayTransactions[index];
                                return transaction is ExpenseModel
                                    ? TransactionTile(
                                        transaction: transaction,
                                      )
                                    : TransactionTile(
                                        transaction: transaction,
                                      );
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (yesterdayTransactions.isNotEmpty) ...[
                            Text(
                              'Yesterday',
                              style: AppStyle.poppinsBoldBlack(fontSize: 20),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: yesterdayTransactions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var transaction = yesterdayTransactions[index];
                                return transaction is ExpenseModel
                                    ? TransactionTile(
                                        transaction: transaction,
                                      )
                                    : TransactionTile(
                                        transaction: transaction,
                                      );
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (lastWeekTransactions.isNotEmpty) ...[
                            Text(
                              'Last Week',
                              style: AppStyle.poppinsBoldBlack(fontSize: 20),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: lastWeekTransactions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var transaction = lastWeekTransactions[index];
                                return transaction is ExpenseModel
                                    ? TransactionTile(
                                        transaction: transaction,
                                      )
                                    : TransactionTile(
                                        transaction: transaction,
                                      );
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context,
      {required AppLocalizations localization, required Size size}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final controller = Get.find<TransactionsScreenController>();
        return Container(
          height: size.height * 0.60,
          decoration: const BoxDecoration(
            color: lightThemeColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.h,
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: violetColor[60],
                    ),
                  ),
                ),
                16.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.msg_filter_transaction,
                        style: AppStyle.poppinsBoldBlack(fontSize: 18)),
                    ElevatedButton(
                      onPressed: () {
                        controller.resetFilters();
                        controller.applyFilters();
                      },
                      child: Text(localization.lbl_reset),
                    ),
                  ],
                ),
                16.h,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(localization.msg_filter_by,
                      style: AppStyle.poppinsBoldBlack(fontSize: 18)),
                ),
                8.h,
                Row(
                  children: [
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          label: Text(
                            localization.lbl_income,
                            style: TextStyle(
                              color: controller.isIncomeSelected.value
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          selected: controller.isIncomeSelected.value,
                          onSelected: (selected) {
                            controller.toggleIncomeFilter(selected);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                        )),
                    8.h,
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          label: Text(
                            localization.lbl_expense,
                            style: TextStyle(
                              color: controller.isExpenseSelected.value
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          selected: controller.isExpenseSelected.value,
                          onSelected: (selected) {
                            controller.toggleExpenseFilter(selected);
                          },
                        )),
                  ],
                ),
                16.h,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localization.msg_sort_by,
                    style: AppStyle.poppinsBoldBlack(
                      fontSize: 18,
                    ),
                  ),
                ),
                8.h,
                Wrap(
                  spacing: 8,
                  children: [
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            localization.msg_highest,
                            style: TextStyle(
                              color: controller.sortBy.value == SortBy.highest
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          selected: controller.sortBy.value == SortBy.highest,
                          onSelected: (selected) {
                            controller.setSortBy(SortBy.highest);
                          },
                        )),
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            localization.msg_lowest,
                            style: TextStyle(
                              color: controller.sortBy.value == SortBy.lowest
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          selected: controller.sortBy.value == SortBy.lowest,
                          onSelected: (selected) {
                            controller.setSortBy(SortBy.lowest);
                          },
                        )),
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            localization.msg_newest,
                            style: TextStyle(
                              color: controller.sortBy.value == SortBy.newest
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          selected: controller.sortBy.value == SortBy.newest,
                          onSelected: (selected) {
                            controller.setSortBy(SortBy.newest);
                          },
                        )),
                    Obx(() => ChoiceChip(
                          showCheckmark: false,
                          backgroundColor: lightThemeColor,
                          selectedColor: violetColor[20],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          label: Text(
                            localization.msg_oldest,
                            style: TextStyle(
                              color: controller.sortBy.value == SortBy.oldest
                                  ? violetColor
                                  : darkThemeColor,
                            ),
                          ),
                          selected: controller.sortBy.value == SortBy.oldest,
                          onSelected: (selected) {
                            controller.setSortBy(SortBy.oldest);
                          },
                        )),
                  ],
                ),
                16.h,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localization.lbl_category,
                    style: AppStyle.poppinsBoldBlack(
                      fontSize: 16,
                    ),
                  ),
                ),
                8.h,
                GestureDetector(
                  onTap: () {
                    // Implement category selection logic here
                    // controller.selectCategory();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localization.msg_choose_category,
                        style: AppStyle.poppinsMediumBlack(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              controller.selectedCategory.value,
                              style: AppStyle.poppinsMediumBlack(fontSize: 16),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                16.h,
                buildElevatedButton(
                  height: 56,
                  width: double.maxFinite,
                  onTapped: () {
                    controller.applyFilters();
                    Navigator.pop(context);
                  },
                  title: localization.lbl_apply_filters,
                  bgColor: violetColor,
                  fgColor: lightThemeColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
