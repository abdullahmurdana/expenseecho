import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen.dart';
import 'package:expenseecho/presentation/home/main_screen/main_screen_controller.dart';
import 'package:expenseecho/presentation/profile/profile_screen/profile_screen.dart';
import 'package:expenseecho/widgets/expandable_fab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.index});

  final int index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.find<MainScreenController>();

  Widget _buildAnimatedBottomNavbar(MainScreenController controller) {
    return Obx(
      () => AnimatedBottomNavigationBar.builder(
        itemCount: controller.iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? violetColor : darkThemeColor[25];
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  controller.titleList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                ),
              )
            ],
          );
        },
        backgroundColor: lightThemeColor,
        activeIndex: controller.bottomNavIndex.value,
        notchMargin: -70,
        notchSmoothness:
            NotchSmoothness.verySmoothEdge, // Smoother, smaller notch
        gapLocation: GapLocation.center,
        onTap: (index) => controller.changeTabIndex(index),
      ),
    );
  }

  ExpandableFab _buildFAB() {
    return ExpandableFab(
      actionButtonElevation: 0,
      color: violetColor,
      fabSize: 50,
      fabMargin: 40,
      icon: const Icon(Icons.add, size: 30, color: lightThemeColor),
      children: [
        ActionButton(
          color: greenThemeColor,
          icon: Image.asset("assets/icons/income_icon_light.png"),
          onPressed: () {
            // TODO Navigate to Add Transfer screen
            Get.toNamed(AppRoutes.incomeAddNewScreen);
          },
          heroTag: 'income',
        ),
        ActionButton(
          color: blueThemeColor,
          icon: Image.asset("assets/icons/transfer_icon_light.png"),
          onPressed: () {
            // TODO Navigate to Add Transfer screen
            Get.toNamed(AppRoutes.transferAddNewScreen);
          },
          heroTag: 'transfer',
        ),
        ActionButton(
          color: redThemeColor,
          icon: Image.asset("assets/icons/expense_icon_light.png"),
          onPressed: () {
            // TODO Navigate to Add Expense screen
            Get.toNamed(AppRoutes.expenseAddNewScreen);
          },
          heroTag: 'expense',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.bottomNavIndex.value,
            children: const [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              ProfileScreen(),
            ],
          )),
      bottomNavigationBar: _buildAnimatedBottomNavbar(controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFAB(),
    );
  }
}
