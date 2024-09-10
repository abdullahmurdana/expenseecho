import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/hex_color.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

import 'email_verification_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final otpController = Get.find<EmailVerificationController>();
  Timer? _timer;
  int _start = 285;
  String? _email;

  @override
  void initState() {
    startTimer();
    _email = "mimimurdana@gmail.com";
    // _email = widget.email;
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final localization = AppLocalizations.of(context)!;

    final double topVerticalGap = screenHeight * 0.05;
    final double horizontalPadding = screenWidth * 0.04;
    final double verticalGap = screenHeight * 0.02;
    // final double buttonHeight = screenHeight * 0.068;
    // final double buttonWidth = screenWidth * 0.92;
    // final double buttonRadius = buttonHeight / 0.028;
    // final double buttonTextSize = screenHeight * 0.03;
    final double titleFontSize = screenHeight * 0.035;
    final double otpFontSize = screenHeight * 0.03;
    final double timerFontSize = screenHeight * 0.025;
    final double textFontSize = screenHeight * 0.018;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightThemeColor,
        title: Text(localization.lbl_verification),
      ),
      backgroundColor: lightThemeColor,
      body: SafeArea(
        child: GetBuilder<EmailVerificationController>(
          init: Get.find<EmailVerificationController>(),
          builder: (controller) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topVerticalGap.h,
                        // Title bar
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: _buildTitlebar(
                              localization: localization,
                              controller: controller,
                              titleFontSize: titleFontSize),
                        ),
                        verticalGap.h,
                        // OTP Display
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: _buildOtpDisplay(context,
                              controller: controller, otpFontSize: otpFontSize),
                        ),
                        verticalGap.h,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: Text(
                            timerText,
                            style: AppStyle.poppinsCustom(
                                fontSize: timerFontSize,
                                color: violetColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        verticalGap.h,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: _buildTextSpan(
                              localization: localization,
                              textFontSize: textFontSize),
                        ),
                        verticalGap.h,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: _buildResendOtpButton(
                              localization: localization,
                              textFontSize: textFontSize),
                        ),
                        verticalGap.h,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: buildElevatedButton(
                            height: 56,
                            width: size.width,
                            onTapped: () {},
                            title: localization.lbl_verify,
                            bgColor: violetColor,
                            fgColor: lightThemeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildCustomKeyboard(
                    controller: controller,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
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

  _buildTextSpan(
      {required AppLocalizations localization, required double textFontSize}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: localization.msg_sent_verify_email_txt1,
          style: AppStyle.poppinsMediumBlack(fontSize: textFontSize)),
      TextSpan(
        text: _email,
        style: AppStyle.poppinsCustom(
            fontSize: textFontSize,
            color: violetColor,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
          text: localization.msg_sent_verify_email_txt2,
          style: AppStyle.poppinsMediumBlack(fontSize: textFontSize)),
    ]));
  }

  _buildResendOtpButton(
      {required AppLocalizations localization, required double textFontSize}) {
    return GestureDetector(
      child: Text(
        localization.lbl_didnt_received_email,
        textAlign: TextAlign.left,
        style: AppStyle.poppinsCustom(
          fontSize: textFontSize,
          color: violetColor,
          fontWeight: FontWeight.bold,
          textDecoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildTitlebar(
      {required AppLocalizations localization,
      required EmailVerificationController controller,
      required double titleFontSize}) {
    return Center(
      child: Text(
        localization.lbl_enter_verification,
        maxLines: 2,
        softWrap: true,
        style: AppStyle.poppinsMediumBlack(fontSize: titleFontSize),
      ),
    );
  }

  Widget _buildOtpDisplay(BuildContext context,
      {required EmailVerificationController controller,
      required double otpFontSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(6, (index) {
        return Obx(() {
          return controller.otp.value.length > index
              ? Padding(
                  padding: EdgeInsets.only(right: otpFontSize),
                  child: Text(
                    controller.otp.value[index],
                    style: AppStyle.poppinsMediumBlack(fontSize: otpFontSize),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(right: otpFontSize),
                  width: otpFontSize,
                  height: otpFontSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightThemeColor[20],
                  ),
                );
        });
      }),
    );
  }

  Widget _buildCustomKeyboard({
    required EmailVerificationController controller,
    required double screenHeight,
    required double screenWidth,
  }) {
    var keyboardHeight = screenHeight * 0.30;
    var buttonWidth = (screenWidth - 10 - 12) / 3;
    double buttonHeight = screenHeight * 0.055;
    return Container(
      height: keyboardHeight,
      color: HexColor("#D6DADF"),
      child: Column(
        children: [
          7.h,
          // First Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return _buildKeyboardButton(index + 1, controller,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  buttonHeight: buttonHeight,
                  buttonWidth: buttonWidth);
            }),
          ),
          7.h,
          // Second Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return _buildKeyboardButton(index + 4, controller,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  buttonHeight: buttonHeight,
                  buttonWidth: buttonWidth);
            }),
          ),
          7.h,
          // Third Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return _buildKeyboardButton(index + 7, controller,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  buttonHeight: buttonHeight,
                  buttonWidth: buttonWidth);
            }),
          ),
          7.h,
          // Fourth Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildKeyboardButton(0, controller,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  buttonHeight: buttonHeight,
                  buttonWidth: buttonWidth),
              11.w,
              ElevatedButton(
                onPressed: controller.removeLastDigit,
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  fixedSize: Size(buttonWidth, buttonHeight),
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.only(right: 12, top: 3),
                  elevation: 0,
                ),
                child: Icon(
                  size: screenHeight * 0.035,
                  Icons.backspace_outlined,
                  color: darkThemeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(
    int digit,
    EmailVerificationController controller, {
    required double screenWidth,
    required double screenHeight,
    required double buttonHeight,
    required double buttonWidth,
  }) {
    return OutlinedButton(
      onPressed: () => controller.addDigit(digit),
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        fixedSize: Size(buttonWidth, buttonHeight),
        backgroundColor: lightThemeColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        '$digit',
        style: AppStyle.poppinsMediumBlack(fontSize: screenHeight * 0.03),
      ),
    );
  }
}
