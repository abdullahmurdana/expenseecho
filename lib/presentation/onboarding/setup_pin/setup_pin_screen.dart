import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';

import 'setup_pin_controller.dart';

class SetupPinScreen extends StatelessWidget {
  const SetupPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: violetColor,
      body: SafeArea(
        child: GetBuilder<SetupPinController>(
          init: Get.find<SetupPinController>(),
          builder: (controller) {
            return Stack(
              children: [
                // Title bar
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: _buildTitlebar(
                      localization: localization, controller: controller),
                ),
                // OTP Display
                Positioned(
                  top: size.height * 0.25,
                  left: 0,
                  right: 0,
                  child: _buildOtpDisplay(controller),
                ),
                // Custom Keyboard
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: _buildCustomKeyboard(controller),
                ),
                // Loading Indicator
                if (controller.isLoading.value)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CustomLoadingIndicator(),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitlebar(
      {required AppLocalizations localization,
      required SetupPinController controller}) {
    return Center(
      child: Text(
        controller.isConfirming.value
            ? localization.lbl_confirm_pin
            : localization.lbl_enter_pin,
        style: AppStyle.poppinsMediumWhite(fontSize: 24),
      ),
    );
  }

  Widget _buildOtpDisplay(SetupPinController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Obx(() {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: violetColor[20]!, width: 3),
              color: controller.otp.value.length > index
                  ? lightThemeColor
                  : Colors.transparent,
            ),
          );
        });
      }),
    );
  }

  Widget _buildCustomKeyboard(SetupPinController controller) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // First Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return _buildKeyboardButton(index + 1, controller);
              }),
            ),
          ),
          const SizedBox(height: 10),
          // Second Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return _buildKeyboardButton(index + 4, controller);
              }),
            ),
          ),
          const SizedBox(height: 10),
          // Third Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return _buildKeyboardButton(index + 7, controller);
              }),
            ),
          ),
          const SizedBox(height: 10),
          // Fourth Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.removeLastDigit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: violetColor,
                    elevation: 0,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(
                    Icons.backspace,
                    size: 34,
                    color: lightThemeColor,
                  ),
                ),
                _buildKeyboardButton(0, controller),
                ElevatedButton(
                  onPressed: controller.submitOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: violetColor,
                    elevation: 0,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(
                    size: 34,
                    Icons.done,
                    color: lightThemeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(int digit, SetupPinController controller) {
    return OutlinedButton(
      onPressed: () => controller.addDigit(digit),
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: violetColor,
        padding: const EdgeInsets.all(20),
        elevation: 0,
      ),
      child: Text(
        '$digit',
        style: AppStyle.poppinsBoldWhite(fontSize: 30),
      ),
    );
  }
}
