import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/core/utils/validation_methods.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';
import 'package:expenseecho/presentation/onboarding/login_screen/login_screen_controller.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:expenseecho/widgets/custom_password_field.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:expenseecho/widgets/custom_loading_indicator.dart';
import 'package:expenseecho/widgets/blurred_background_widget.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loginController = Get.find<LoginScreenController>();

  @override
  void initState() {
    _emailcontroller = TextEditingController(text: 'mimimurdana@gmail.com');
    _passwordcontroller = TextEditingController(text: 'mimi1234');
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(localization.txt_login),
              backgroundColor: lightThemeColor,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                color: lightThemeColor,
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        15.h,
                        PasswordField(
                          controller: _passwordcontroller,
                          hintText: localization.lbl_hint_enter_password,
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
                        ),
                        35.h,
                        _buildLoginButton(
                            size: size, localization: localization),
                        25.h,
                        _buildForgotPasswordButton(localization: localization),
                        25.h,
                        _buildCreateNewAccountTextButton(
                            localization: localization),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (loginController.isLoading.value)
            const Positioned.fill(
              child: BlurredBackground(
                child: CustomLoadingIndicator(),
              ),
            ),
        ],
      );
    });
  }

  _buildCreateNewAccountTextButton({required AppLocalizations localization}) {
    return RichText(
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account yet? ",
            style: AppStyle.poppinsCustom(
                fontSize: 14,
                color: darkThemeColor[50]!,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Sign Up',
            style: AppStyle.poppinsCustom(
                fontSize: 15,
                color: violetColor,
                fontWeight: FontWeight.bold,
                textDecoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                debugPrint('---> Login button tapped');
              },
          ),
        ],
      ),
    );
  }

  _buildForgotPasswordButton({required AppLocalizations localization}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.forgotScreen);
      },
      child: Text(
        localization.msg_forgot_password,
        textAlign: TextAlign.left,
        style: AppStyle.poppinsCustom(
          fontSize: 16,
          color: violetColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildLoginButton(
      {required Size size, required AppLocalizations localization}) {
    return ElevatedButton(
      onPressed: loginController.isLoading.value
          ? null
          : () async {
              String email = _emailcontroller.text;
              String password = _passwordcontroller.text;
              bool success = await loginController.signIn(
                  email: email, password: password);
              if (success) {
                final pin = await SharedPreferencesHandler.getPin();
                print(
                    "---> Launch Screen Controller :: PIN Available :: ${pin?.isNotEmpty}");
                if (pin != null) {
                  Get.offNamed(AppRoutes.setupPinScreen,
                      arguments: {'verifyPin': true});
                } else {
                  Get.offNamed(AppRoutes.setupPinScreen,
                      arguments: {'verifyPin': false});
                }
              }
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
        localization.txt_login,
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
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
}
