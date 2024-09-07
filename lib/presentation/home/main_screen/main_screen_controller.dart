import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var bottomNavIndex = 0.obs;
  final _showFab = false.obs;

  bool get showFab => _showFab.value;

  final iconList = <IconData>[
    Icons.home,
    Icons.arrow_circle_right_sharp,
    Icons.circle_notifications,
    Icons.person,
  ];

  final titleList = <String>[
    "Home",
    "Transactions",
    "Notifications",
    "Profile",
  ];

  void changeTabIndex(int index) {
    bottomNavIndex.value = index;
    _showFab.value = index == 1;
  }
}
