import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.find<HomeScreenController>();

  var dummyExpenses = <ExpenseModel>[];
  var dummyIncomes = <IncomeModel>[];

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
    // final homeScreenController = Get.put(HomeScreenController(), permanent: true);
    final size = MediaQuery.of(context).size;
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: _buildTimeFrameChips(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFrameChips() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            label: const Text('Today'),
            selected: homeScreenController.selectedTimeFrame.value == 'Today',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.selectedTimeFrame.value = 'Today';
                homeScreenController.filterData(
                    'Today', dummyExpenses, dummyIncomes);
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Week'),
            selected: homeScreenController.selectedTimeFrame.value == 'Week',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.selectedTimeFrame.value = 'Week';
                homeScreenController.filterData(
                    'Week', dummyExpenses, dummyIncomes);
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Month'),
            selected: homeScreenController.selectedTimeFrame.value == 'Month',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.selectedTimeFrame.value = 'Month';
                homeScreenController.filterData(
                    'Month', dummyExpenses, dummyIncomes);
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Year'),
            selected: homeScreenController.selectedTimeFrame.value == 'Year',
            onSelected: (selected) {
              if (selected) {
                homeScreenController.selectedTimeFrame.value = 'Year';
                homeScreenController.filterData(
                    'Year', dummyExpenses, dummyIncomes);
              }
            },
          ),
        ],
      );
    });
  }

  Widget buildSpendFrequencyGraph() {
    return Obx(() {
      // Combine and sum the expenses and incomes data to create the graph points
      List<FlSpot> spots = [];
      double cumulativeSum = 0;

      // Create a list to hold both expenses and incomes sorted by date
      List<Map<String, dynamic>> combinedData = [];

      for (var expense in homeScreenController.filteredExpenses) {
        combinedData.add({
          'date': DateTime.parse(expense.createdAt ?? ''),
          'amount': -expense.expenseAmount, // Expenses reduce the total
        });
      }

      for (var income in homeScreenController.filteredIncomes) {
        combinedData.add({
          'date': DateTime.parse(income.created ?? ''),
          'amount': income.incomeAmount, // Incomes increase the total
        });
      }

      // Sort combined data by date
      combinedData.sort((a, b) => a['date'].compareTo(b['date']));

      // Generate the FlSpot list for the graph
      for (int i = 0; i < combinedData.length; i++) {
        cumulativeSum += combinedData[i]['amount'];
        spots.add(FlSpot(i.toDouble(), cumulativeSum));
      }

      return SizedBox(
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
            maxX: spots.isNotEmpty ? spots.length.toDouble() - 1 : 6,
            minY: spots.isNotEmpty
                ? spots.map((s) => s.y).reduce((a, b) => a < b ? a : b)
                : 0,
            maxY: spots.isNotEmpty
                ? spots.map((s) => s.y).reduce((a, b) => a > b ? a : b)
                : 6,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
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
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const SizedBox(),
      toolbarHeight: 250,
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
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/images/avatar_image.png",
                        height: 48,
                        width: 48,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: violetColor,
                          size: 25,
                        ),
                        Text(
                          "October",
                          style: AppStyle.poppinsMediumBlack(fontSize: 18),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.transferDetailsScreen),
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
                  Text(
                    '\$9400',
                    style: AppStyle.poppinsBoldBlack(fontSize: 28),
                  ),
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
                        await homeScreenController.getExpenses();
                        await homeScreenController.getIncomeList();
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
                              Text(
                                '\$1200',
                                style:
                                    AppStyle.poppinsMediumWhite(fontSize: 18),
                              )
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
                              Text(
                                '\$1200',
                                style:
                                    AppStyle.poppinsMediumWhite(fontSize: 18),
                              )
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
