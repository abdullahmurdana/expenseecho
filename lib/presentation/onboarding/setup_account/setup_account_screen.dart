import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/routes/app_routes.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  _SetupAccountScreenState createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          color: lightThemeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitleTextWidget(),
                _buildButton(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTitleTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Text(
            "Let's setup your account",
            style: AppStyle.gfPoppinsMediumBlack(fontSize: 32),
          ),
          20.h,
          Text(
            "Account can be your bank, credit card or your wallet.",
            style: AppStyle.gfPoppinsRegularBlack(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Padding _buildButton(Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addNewAccountScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: violetColor,
          foregroundColor: lightThemeColor,
          fixedSize: Size(size.width, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "Let's Go",
          style: AppStyle.gfPoppinsMediumWhite(fontSize: 22),
        ),
      ),
    );
  }

  _buildElevatedButton({required Size size}) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.emailVerificationScreen);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: violetColor,
        foregroundColor: lightThemeColor,
        fixedSize: Size(size.width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        "Let's Go",
        style: AppStyle.gfPoppinsMediumWhite(fontSize: 22),
      ),
    );
  }
}
