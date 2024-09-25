import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/shared_preferences/category_preferences.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_report_details/financial_report_details_controller.dart';
import 'package:expenseecho/widgets/custom_category_tile.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/custom_transaction_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinancialReportDetailsScreen extends StatefulWidget {
  const FinancialReportDetailsScreen({super.key});

  @override
  _FinancialReportDetailsScreenState createState() =>
      _FinancialReportDetailsScreenState();
}

class _FinancialReportDetailsScreenState
    extends State<FinancialReportDetailsScreen> {
  final financialReportDetailsController =
      Get.find<FinancialReportDetailsController>();
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    var topChartContainerHeight = size.height * 0.39;
    return Scaffold(
      appBar: buildAppBar(localization),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildChartWidget(
                  size: size,
                  topChartHeight: topChartContainerHeight,
                ),
                buildExpIncToggleButton(size, localization: localization),
                buildTransactionWidget(size, localization: localization),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildTransactionWidget(Size size,
      {required AppLocalizations localization}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: lightThemeColor[20]!,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Obx(() {
                    final controller =
                        Get.find<FinancialReportDetailsController>();
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/arrow_down_violet.png",
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 100,
                          height: 56,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 5),
                            ),
                            // decoration: ,
                            value: controller.selectedDropdown.value,
                            icon: const SizedBox.shrink(),
                            elevation: 16,
                            style: AppStyle.poppinsMediumBlack(fontSize: 14),
                            onChanged: (String? newValue) {
                              controller.selectedDropdown.value = newValue!;
                            },
                            items: <String>['Transactions', 'Category']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: lightThemeColor[20]!,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.sort_down,
                  size: 25,
                  color: darkThemeColor,
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (financialReportDetailsController.isLoading.value) {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }

          if (financialReportDetailsController.selectedDropdown.value ==
              'Transactions') {
            var transactions = financialReportDetailsController.isSelected[0]
                ? financialReportDetailsController.expenses
                : financialReportDetailsController.income;
            // var totalAmounts = financialReportDetailsController.isSelected[0]
            //     ? financialReportDetailsController.totalExpenseForCurrentMonth
            //     : financialReportDetailsController.totalIncomeForCurrentMonth;

            if (transactions.isEmpty) {
              return const Center(
                child: Text('No transactions yet'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: transactions.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  return financialReportDetailsController.isSelected[0]
                      ? TransactionTile(
                          transaction: transaction,
                        )
                      : TransactionTile(
                          transaction: transaction,
                        );
                },
              ),
            );
          } else {
            // Handle category view
            var transactions = financialReportDetailsController.isSelected[0]
                ? financialReportDetailsController.expenses
                : financialReportDetailsController.income;

            if (transactions.isEmpty) {
              return const Center(
                child: Text('No Transactions yet'),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var transaction = transactions[index];
                return financialReportDetailsController.isSelected[0]
                    ? CategoryTile(
                        transaction: transaction,
                        isExpense: true,
                        totalAmount: financialReportDetailsController
                            .totalExpenseForCurrentMonth.value,
                      )
                    : CategoryTile(
                        transaction: transaction,
                        isExpense: false,
                        totalAmount: financialReportDetailsController
                            .totalIncomeForCurrentMonth.value,
                      );
              },
            );
          }
        }),
      ],
    );
  }

  Padding buildExpIncToggleButton(Size size,
      {required AppLocalizations localization}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Obx(() {
        final width = size.width;
        final controller = Get.find<FinancialReportDetailsController>();
        return Container(
          width: width,
          height: 56,
          child: Center(
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(25.0),
              textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                inherit: true,
              ),
              fillColor: violetColor,
              selectedColor: lightThemeColor,
              color: violetColor,
              isSelected: controller.isSelected,
              onPressed: (int index) {
                controller.toggleSelection(index);
              },
              children: <Widget>[
                Container(
                  width: (width - 35) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    localization.lbl_expense,
                    style: const TextStyle(
                      inherit: true,
                    ),
                  ),
                ),
                Container(
                  width: (width - 35) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    localization.lbl_income,
                    style: const TextStyle(
                      inherit: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Container buildChartWidget(
      {required Size size, required double topChartHeight}) {
    return Container(
      // color: lightThemeColor[20],
      width: size.width,
      height: topChartHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: topChartHeight * 0.21, // This widget height = 50
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
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
                  SizedBox(
                    height: 48,
                    width: 99,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(16.0),
                      fillColor: violetColor,
                      selectedColor: violetColor,
                      color: violetColor,
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          // Update the isSelected list based on the index
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      children: <Widget>[
                        // Change images based on the selection state
                        Image.asset(isSelected[0]
                            ? "assets/icons/line_chart_light.png"
                            : "assets/icons/line_chart_violet.png"),
                        Image.asset(isSelected[1]
                            ? "assets/icons/pie_chart_light.png"
                            : "assets/icons/pie_chart_violet.png"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() {
            final controller = Get.find<FinancialReportDetailsController>();
            if (controller.isSelected[0]) {
              // Expense selected
              if (isSelected[0]) {
                // Line chart selected
                return buildLineChart(
                  size: size,
                  topChartHeight: topChartHeight,
                  isExpense: true,
                );
                // return buildSyncfusionLineChart(
                //   size: size,
                //   topChartHeight: topChartHeight,
                //   isExpense: true,
                // );
              } else {
                // Pie chart selected
                return buildDoughnutChart(
                  size: size,
                  topChartHeight: topChartHeight,
                  isExpense: true,
                );
                // return buildPieChart(
                //   size: size,
                //   topChartHeight: topChartHeight,
                //   isExpense: true,
                // );
              }
            } else {
              // Income selected
              if (isSelected[0]) {
                // Line chart selected
                return buildLineChart(
                  size: size,
                  topChartHeight: topChartHeight,
                  isExpense: false,
                );
              } else {
                // Doughnut chart
                return buildDoughnutChart(
                  size: size,
                  topChartHeight: topChartHeight,
                  isExpense: false,
                );
                // Pie chart selected
                /* return buildPieChart(
                  size: size,
                  topChartHeight: topChartHeight,
                  isExpense: false,
                ); */
              }
            }
          }),
        ],
      ),
    );
  }

  Widget buildLineChart({
    required Size size,
    required double topChartHeight,
    required bool isExpense,
  }) {
    final controller = Get.find<FinancialReportDetailsController>();
    final data = isExpense
        ? controller.expenses
            .map((e) =>
                FlSpot(e.createdAtDateTime!.day.toDouble(), e.expenseAmount))
            .toList()
        : controller.income
            .map((i) =>
                FlSpot(i.createdAtDateTime!.day.toDouble(), i.incomeAmount))
            .toList();

    // Calculate minY and maxY for the chart
    double minY = data.isNotEmpty
        ? data.map((s) => s.y).reduce((a, b) => a < b ? a : b)
        : 0;
    double maxY = data.isNotEmpty
        ? data.map((s) => s.y).reduce((a, b) => a > b ? a : b)
        : 6;

    double minX = data.isNotEmpty
        ? data.map((s) => s.x).reduce((a, b) => a < b ? a : b)
        : 0;
    double maxX = data.isNotEmpty
        ? data.map((s) => s.x).reduce((a, b) => a > b ? a : b)
        : 6;

    // Ensure minX and maxX have a meaningful range
    if (minX == maxX) {
      minX -= 10;
      maxX += 10;
    }

    // Debug prints
    print('Data: $data');
    print('minX: $minX, maxX: $maxX, minY: $minY, maxY: $maxY');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topChartHeight * 0.78,
          width: size.width,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.transparent),
              ),
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: data,
                  isCurved: true,
                  color: violetColor,
                  barWidth: 3,
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
      ],
    );
  }

  Widget buildSyncfusionLineChart({
    required Size size,
    required double topChartHeight,
    required bool isExpense,
  }) {
    final controller = Get.find<FinancialReportDetailsController>();
    final data = isExpense
        ? controller.expenses
            .map((e) =>
                ChartData(e.createdAtDateTime!.day.toDouble(), e.expenseAmount))
            .toList()
        : controller.income
            .map((i) =>
                ChartData(i.createdAtDateTime!.day.toDouble(), i.incomeAmount))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topChartHeight * 0.78,
          width: size.width,
          child: SfCartesianChart(
            primaryXAxis: const NumericAxis(isVisible: false),
            primaryYAxis: const NumericAxis(isVisible: false),
            series: <CartesianSeries>[
              LineSeries<ChartData, double>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: violetColor,
                width: 3,
                markerSettings: const MarkerSettings(isVisible: false),
                dataLabelSettings: const DataLabelSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPieChart(
      {required Size size,
      required double topChartHeight,
      required bool isExpense}) {
    final controller = Get.find<FinancialReportDetailsController>();
    final data = isExpense ? controller.expenses : controller.income;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topChartHeight * 0.78,
          child: FutureBuilder<List<CategoryModel>>(
            future: isExpense
                ? CategoryPreferences.loadExpenseCategories()
                : CategoryPreferences.loadIncomeCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading categories'));
              } else {
                final categories = snapshot.data!;
                final pieData = data.map((item) {
                  if (isExpense) {
                    final transaction = item as ExpenseModel;
                    final category = categories
                        .firstWhere((cat) => cat.name == transaction.category);
                    return PieChartSectionData(
                      value: transaction.expenseAmount,
                      color: category.foregroundColor,
                      title: category.name,
                    );
                  } else {
                    final transaction = item as IncomeModel;
                    final category = categories
                        .firstWhere((cat) => cat.name == transaction.category);
                    return PieChartSectionData(
                      value: transaction.incomeAmount,
                      color: category.foregroundColor,
                      title: category.name,
                    );
                  }
                }).toList();

                return SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<PieChartSectionData, String>(
                      dataSource: pieData,
                      xValueMapper: (PieChartSectionData data, _) => data.title,
                      yValueMapper: (PieChartSectionData data, _) => data.value,
                      pointColorMapper: (PieChartSectionData data, _) =>
                          data.color,
                      dataLabelMapper: (PieChartSectionData data, _) =>
                          '${data.title} - ${data.value}',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        connectorLineSettings: ConnectorLineSettings(
                          type: ConnectorType.curve,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildDoughnutChart(
      {required Size size,
      required double topChartHeight,
      required bool isExpense}) {
    final controller = Get.find<FinancialReportDetailsController>();
    final data = isExpense ? controller.expenses : controller.income;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topChartHeight * 0.78,
          child: FutureBuilder<List<CategoryModel>>(
            future: isExpense
                ? CategoryPreferences.loadExpenseCategories()
                : CategoryPreferences.loadIncomeCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading categories'));
              } else {
                final categories = snapshot.data!;
                final doughnutData = data.map((item) {
                  if (isExpense) {
                    final transaction = item as ExpenseModel;
                    final category = categories
                        .firstWhere((cat) => cat.name == transaction.category);
                    return PieChartSectionData(
                      value: transaction.expenseAmount,
                      color: category.foregroundColor,
                      title: category.name,
                    );
                  } else {
                    final transaction = item as IncomeModel;
                    final category = categories
                        .firstWhere((cat) => cat.name == transaction.category);
                    return PieChartSectionData(
                      value: transaction.incomeAmount,
                      color: category.foregroundColor,
                      title: category.name,
                    );
                  }
                }).toList();

                return SfCircularChart(
                  series: <CircularSeries>[
                    DoughnutSeries<PieChartSectionData, String>(
                      dataSource: doughnutData,
                      innerRadius: '80%',
                      xValueMapper: (PieChartSectionData data, _) => data.title,
                      yValueMapper: (PieChartSectionData data, _) => data.value,
                      pointColorMapper: (PieChartSectionData data, _) =>
                          data.color,
                      // Set Data Labels for doughnut charts
                      /* dataLabelMapper: (PieChartSectionData data, _) =>
                          '${data.title} - ${data.value}',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        borderRadius: BorderSide.strokeAlignInside,
                        labelPosition: ChartDataLabelPosition.outside,
                        connectorLineSettings: ConnectorLineSettings(
                          type: ConnectorType.curve,
                        ),
                      ), */
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(AppLocalizations localization) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          size: 24,
        ),
      ),
      title: Text(
        localization.lbl_financial_report,
        style: AppStyle.poppinsMediumBlack(fontSize: 20),
      ),
    );
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}
