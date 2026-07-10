import 'package:expenseecho/core/utils/validation_methods.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';

import 'package:expenseecho/core/utils/app_styles.dart';
import 'package:expenseecho/core/utils/sized_box_extensions.dart';
import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/widgets/custom_password_field.dart';
import 'package:expenseecho/widgets/custom_widgets.dart';
import 'sign_up_screen_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = AppLocalizations.of(context)!;
    final signUpController = Get.put(SignUpScreenController());

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
                  key: signUpController.formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        height: 56,
                        width: double.maxFinite,
                        controller: signUpController.nameController.value,
                        hintText: localization.lbl_hint_enter_name,
                        labelText: localization.lbl_name,
                      ),
                      16.h,
                      buildTextField(
                        height: 56,
                        width: double.maxFinite,
                        controller: signUpController.emailController.value,
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
                      Obx(() => PasswordField(
                            height: 56,
                            width: double.maxFinite,
                            controller:
                                signUpController.passwordController.value,
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
                            onFocusChanged:
                                signUpController.onPasswordFocusChanged,
                          )),
                      15.h,
                      _buildCheckBoxForTerms(
                          localization: localization,
                          signUpController: signUpController),
                      25.h,
                      buildElevatedButton(
                        height: 56,
                        width: size.width,
                        onTapped: () {
                          signUpController.signUp().then((value) async {
                            if (value) {
                              Get.snackbar(localization.msg_success,
                                  localization.msg_success_signup);

                              Future.delayed(
                                const Duration(seconds: 2),
                              );

                              final pin = await UserPreferences.getPin();
                              print(
                                  "---> Signup Screen Controller :: PIN Available :: ${pin?.isNotEmpty}");
                              if (pin != null) {
                                Get.offNamed(AppRoutes.setupPinScreen,
                                    arguments: {'verifyPin': true});
                              } else {
                                Get.offNamed(AppRoutes.setupPinScreen,
                                    arguments: {'verifyPin': false});
                              }
                            }
                          });
                        },
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
                      20.h,
                      _buildAlreadyHaveAccount(
                          localization: localization,
                          signUpController: signUpController),
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

  Widget _buildCheckBoxForTerms(
      {required AppLocalizations localization,
      required SignUpScreenController signUpController}) {
    return Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: signUpController.termsAccepted.value,
              onChanged: signUpController.toggleTermsAccepted,
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
        ));
  }

  Widget _buildAlreadyHaveAccount(
      {required AppLocalizations localization,
      required SignUpScreenController signUpController}) {
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
              ..onTap = signUpController.goToLogin,
          ),
        ],
      ),
    );
  }
}
