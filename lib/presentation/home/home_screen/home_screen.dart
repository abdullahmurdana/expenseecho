import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen_controller.dart';
import 'package:expenseecho/presentation/profile/accounts/account_screen/account_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/custom_transaction_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightThemeColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Spend Frequency',
                      style: AppStyle.poppinsMediumBlack(fontSize: 18),
                    ),
                    10.h,
                    SizedBox(
                      width: size.width,
                      child: buildSpendFrequencyGraph(),
                    ),
                  ],
                ),
              ),
              15.h,
              _buildTimeFrameChips(localization: localization),
              15.h,
              _buildTransactionWidget(size: size, localization: localization),
            ],
          ),
        ),
      ),
    );
  }

  _buildTransactionWidget(
      {required Size size, required AppLocalizations localization}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.msg_recent_transaction,
                style: AppStyle.poppinsBoldBlack(fontSize: 18),
              ),
              Container(
                height: 32,
                width: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: violetColor[20],
                ),
                child: Center(
                  child: Text(
                    localization.lbl_see_all,
                    style: AppStyle.poppinsCustom(
                      fontSize: 13,
                      color: violetColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          15.h,
          Obx(() {
            if (homeScreenController.isLoading.value) {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }

            if (homeScreenController.allTransactions.isEmpty) {
              return const Center(
                child: Text('No transactions yet'),
              );
            }

            // Get the transactions and sort them by date
            var transactions = homeScreenController.allTransactions.toList();
            transactions.sort((a, b) => b.createdAt
                .compareTo(a.createdAt)); // Assuming 'date' is a DateTime field

            // Take the most recent 3 transactions
            var recentTransactions = transactions.take(3).toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: recentTransactions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var transaction = recentTransactions[index];
                return TransactionTile(
                  transaction: transaction,
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeFrameChips({required AppLocalizations localization}) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            showCheckmark: false,
            label: Text(
              localization.msg_today,
              style: AppStyle.poppinsCustom(
                fontSize: 14,
                color: homeScreenController.selectedTimeFrame.value == 'Today'
                    ? yellowThemeColor
                    : lightThemeColor[20]!,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor:
                homeScreenController.selectedTimeFrame.value == 'Today'
                    ? yellowThemeColor[20]
                    : lightThemeColor,
            selectedColor: yellowThemeColor[20],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide.none,
            ),
            side: BorderSide.none,
            selected: homeScreenController.selectedTimeFrame.value == 'Today',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.filterData('Today');
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            showCheckmark: false,
            label: Text(
              localization.lbl_week,
              style: AppStyle.poppinsCustom(
                fontSize: 14,
                color: homeScreenController.selectedTimeFrame.value == 'Week'
                    ? yellowThemeColor
                    : lightThemeColor[20]!,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor:
                homeScreenController.selectedTimeFrame.value == 'Week'
                    ? yellowThemeColor[20]
                    : lightThemeColor,
            selectedColor: yellowThemeColor[20],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide.none,
            ),
            side: BorderSide.none,
            selected: homeScreenController.selectedTimeFrame.value == 'Week',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.filterData('Week');
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            showCheckmark: false,
            label: Text(
              localization.lbl_month,
              style: AppStyle.poppinsCustom(
                fontSize: 14,
                color: homeScreenController.selectedTimeFrame.value == 'Month'
                    ? yellowThemeColor
                    : lightThemeColor[20]!,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor:
                homeScreenController.selectedTimeFrame.value == 'Month'
                    ? yellowThemeColor[20]
                    : lightThemeColor,
            selectedColor: yellowThemeColor[20],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide.none,
            ),
            side: BorderSide.none,
            selected: homeScreenController.selectedTimeFrame.value == 'Month',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.filterData('Month');
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            showCheckmark: false,
            label: Text(
              localization.lbl_year,
              style: AppStyle.poppinsCustom(
                fontSize: 14,
                color: homeScreenController.selectedTimeFrame.value == 'Year'
                    ? yellowThemeColor
                    : lightThemeColor[20]!,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor:
                homeScreenController.selectedTimeFrame.value == 'Year'
                    ? yellowThemeColor[20]
                    : lightThemeColor,
            selectedColor: yellowThemeColor[20],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide.none,
            ),
            side: BorderSide.none,
            selected: homeScreenController.selectedTimeFrame.value == 'Year',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.filterData('Year');
              }
            },
          ),
        ],
      );
    });
  }

  Widget buildSpendFrequencyGraph() {
    return Obx(() {
      // Ensure chartData is not empty
      if (homeScreenController.chartData.isEmpty) {
        // Provide default data or handle the empty state
        return const Center(
          child: Text('No data available'),
        );
      }

      // Calculate the range of the data
      double minY = homeScreenController.chartData
          .map((s) => s.y)
          .reduce((a, b) => a < b ? a : b);
      double maxY = homeScreenController.chartData
          .map((s) => s.y)
          .reduce((a, b) => a > b ? a : b);

      // Calculate the center point
      double centerY = (minY + maxY) / 2;

      // Adjust minY and maxY to center the chart
      double range = maxY - minY;
      minY = centerY - range / 0.8;
      maxY = centerY + range / 2;

      return Center(
        child: SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.transparent),
              ),
              minX: 0,
              maxX: homeScreenController.chartData.length.toDouble() - 1,
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: homeScreenController.chartData,
                  isCurved: true,
                  color: violetColor,
                  barWidth: 6,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: violetColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const SizedBox(),
      toolbarHeight: 215,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: lightThemeColor,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        "assets/images/avatar_image_1.png",
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: violetColor,
                          size: 25,
                        ),
                        // TODO Add Current Month Name here
                        Text(
                          "October",
                          style: AppStyle.poppinsMediumBlack(fontSize: 18),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                      child: Image.asset(
                        "assets/icons/notification_icon.png",
                      ),
                    ),
                  ],
                ),
              ),
              10.h,
              Column(
                children: <Widget>[
                  const Text('Account balance'),
                  5.h,
                  Obx(() {
                    final controller = Get.find<AccountScreenController>();
                    final totalBalance = controller.accounts
                        .fold<double>(
                            0.0, (sum, account) => sum + account.balance)
                        .toInt();
                    return Text(
                      '\$$totalBalance',
                      style: AppStyle.poppinsBoldBlack(fontSize: 30),
                    );
                  }),
                ],
              ),
              10.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenThemeColor,
                        minimumSize: const Size(170, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        // await homeScreenController.getExpenses();
                        // await homeScreenController.getIncomeList();
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: lightThemeColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Image.asset(
                              "assets/icons/income_icon_green.png",
                              height: 22,
                              width: 22,
                            ),
                          ),
                          15.w,
                          Column(
                            children: [
                              Text(
                                'Income',
                                style:
                                    AppStyle.poppinsRegularWhite(fontSize: 12),
                              ),
                              Obx(() {
                                final incomesTotal =
                                    homeScreenController.incomes.fold(
                                        0,
                                        (sum, item) =>
                                            sum + (item.incomeAmount).toInt());
                                return Text(
                                  '\$$incomesTotal',
                                  style:
                                      AppStyle.poppinsMediumWhite(fontSize: 18),
                                );
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redThemeColor,
                        minimumSize: const Size(170, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: lightThemeColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Image.asset(
                              "assets/icons/expense_icon_red.png",
                              height: 22,
                              width: 22,
                            ),
                          ),
                          15.w,
                          Column(
                            children: [
                              Text(
                                'Expense',
                                style:
                                    AppStyle.poppinsRegularWhite(fontSize: 12),
                              ),
                              Obx(() {
                                final expenseTotal =
                                    homeScreenController.expenses.fold(
                                        0,
                                        (sum, item) =>
                                            sum + (item.expenseAmount).toInt());
                                return Text(
                                  '\$$expenseTotal',
                                  style:
                                      AppStyle.poppinsMediumWhite(fontSize: 18),
                                );
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
