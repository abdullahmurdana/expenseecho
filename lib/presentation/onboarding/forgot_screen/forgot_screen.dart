import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/core/utils/validation_methods.dart';
import 'package:expenseecho/presentation/onboarding/login_screen/login_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final forgotScreenController = Get.find<LoginScreenController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailcontroller;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightThemeColor,
        title: Text(localization.txt_forgot_password),
      ),
      body: SafeArea(
        child: Container(
          color: lightThemeColor,
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  40.h,
                  _buildHeadlineText(),
                  30.h,
                  _buildTextField(
                    controller: _emailcontroller,
                    hintText: localization.lbl_hint_enter_email,
                    labelText: localization.lbl_email,
                    obscureText: false,
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
                  30.h,
                  _buildContinueButton(size: size, localization: localization),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildContinueButton(
      {required Size size, required AppLocalizations localization}) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.loginScreen);
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
        localization.lbl_continue,
        style: AppStyle.poppinsMediumWhite(fontSize: 22),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required bool obscureText,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: lightThemeColor[100],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: lightThemeColor[20]!, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
          labelText: labelText,
          labelStyle: TextStyle(color: darkThemeColor[50]!, fontSize: 16.0),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          suffixIcon:
              icon != null ? Icon(icon, color: darkThemeColor[50]) : null,
        ),
        style: TextStyle(
          color: darkThemeColor[50]!,
          fontSize: 16.0,
        ),
      ),
    );
  }

  RichText _buildHeadlineText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't Worry\n",
            style: AppStyle.poppinsCustom(
                fontSize: 23,
                color: darkThemeColor[75]!,
                fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text:
                "Enter your email and we’ll send you a link to reset your password.",
            style: AppStyle.poppinsCustom(
                fontSize: 23,
                color: darkThemeColor[75]!,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
