import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/hex_color.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/core/utils/validation_methods.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_password_field.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _namecontroller;
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  bool _isPasswordFieldFocused = false; // Add this line

  @override
  void initState() {
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightThemeColor[100],
        title: Text(localization.txt_signup),
      ),
      backgroundColor: lightThemeColor[100],
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                56.h,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        height: 56,
                        width: double.maxFinite,
                        controller: _namecontroller,
                        hintText: localization.lbl_hint_enter_name,
                        labelText: localization.lbl_name,
                      ),
                      16.h,
                      buildTextField(
                        height: 56,
                        width: double.maxFinite,
                        controller: _emailcontroller,
                        hintText: localization.lbl_hint_enter_email,
                        labelText: localization.lbl_email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.msg_enter_email;
                          }
                          if (!isEmailValid(value, isRequired: true)) {
                            return localization.msg_enter_valid_email;
                          }
                          return null;
                        },
                      ),
                      16.h,
                      PasswordField(
                        height: 56,
                        width: double.maxFinite,
                        controller: _passwordcontroller,
                        helperText: localization.msg_password_requirements,
                        labelText: localization.lbl_password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.msg_enter_password;
                          }
                          if (!isPasswordValid(value, isRequired: true)) {
                            return localization.msg_enter_valid_password;
                          }
                          return null;
                        },
                        onFocusChanged: (isFocused) {
                          setState(() {
                            _isPasswordFieldFocused = isFocused;
                          });
                        },
                      ),
                      15.h,
                      _buildCheckBoxForTerms(localization: localization),
                      25.h,
                      buildElevatedButton(
                        height: 56,
                        width: size.width,
                        onTapped: () => Get.toNamed(
                            AppRoutes.emailVerificationScreen,
                            arguments: {'isResetPassword': false}),
                        title: localization.txt_signup,
                        bgColor: violetColor,
                        fgColor: lightThemeColor,
                        textStyle: AppStyle.poppinsMediumWhite(
                          fontSize: 22,
                        ),
                      ),
                      15.h,
                      Center(
                        child: Text(
                          localization.lbl_or_with,
                          style: AppStyle.poppinsCustom(
                            fontSize: 14,
                            color: darkThemeColor[50]!,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      10.h,
                      _buildSignUpWithGoogleButton(
                          size: size, localization: localization),
                      20.h,
                      _buildAlreadyHaveAccount(localization: localization),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBoxForTerms({required AppLocalizations localization}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _termsAccepted,
          onChanged: (bool? value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: localization.msg_by_signing_up_you1,
                  style: AppStyle.poppinsMediumBlack(fontSize: 14),
                ),
                TextSpan(
                  text: localization.msg_by_signing_up_you2,
                  style: AppStyle.poppinsCustom(
                      fontSize: 15,
                      color: violetColor,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint('---> Terms of Service tapped');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildSignUpButton(
      {required Size size, required AppLocalizations localization}) {
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
        localization.txt_signup,
        style: AppStyle.poppinsMediumWhite(fontSize: 22),
      ),
    );
  }

  _buildSignUpWithGoogleButton(
      {required Size size, required AppLocalizations localization}) {
    return ElevatedButton(
      onPressed: () {
        // Define the action for the button press here
        debugPrint('---> Button Pressed');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor('#FCFCFF'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded border
          side: BorderSide(
              color: lightThemeColor[20]!,
              width: 1), // Light black border color
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Padding inside the button
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/google_icon.png',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            width: 28,
            height: 28,
          ),
          15.w,
          Text(
            localization.msg_sign_up_with_google,
            style: AppStyle.poppinsCustom(
                fontSize: 24,
                color: darkThemeColor[75]!,
                fontWeight: FontWeight.bold),
          ), // Text color
        ],
      ),
    );
  }

  _buildAlreadyHaveAccount({required AppLocalizations localization}) {
    return RichText(
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '${localization.msg_already_have_an} ',
            style: AppStyle.poppinsMediumBlack(fontSize: 14),
          ),
          TextSpan(
            text: localization.txt_login,
            style: AppStyle.poppinsCustom(
                fontSize: 15, color: violetColor, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(AppRoutes.loginScreen);
                debugPrint('---> Login button tapped');
              },
          ),
        ],
      ),
    );
  }
}
