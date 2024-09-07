import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/onboarding/launch_screen/launch_screen_controller.dart'; // Import the controller

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final launchScreenController = Get.find<LaunchScreenController>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: violetColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print("Size :: height=${size.height} :: width=${size.width}");
    return Scaffold(
      backgroundColor: violetColor[100],
      // ignore: avoid_unnecessary_containers
      body: Center(
        child: Image.asset(
          "assets/icons/expense_echo_logo.png",
          height: 300,
          width: 300,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
