import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';

class SignUpScreenController extends GetxController {
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var termsAccepted = false.obs;
  var isPasswordFieldFocused = false.obs;

  @override
  void onInit() {
    nameController.value = TextEditingController(text: 'Mimi');
    emailController.value =
        TextEditingController(text: 'mimimurdana@gmail.com');
    passwordController.value = TextEditingController(text: 'Khan1234@');
    super.onInit();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  void toggleTermsAccepted(bool? value) {
    termsAccepted.value = value ?? false;
  }

  void onPasswordFocusChanged(bool isFocused) {
    isPasswordFieldFocused.value = isFocused;
  }

  Future<bool> signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        name: nameController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      bool success = await UserHandler().signUp(user: user);

      return success;
      // Get.toNamed(AppRoutes.emailVerificationScreen,
      //     arguments: {'isResetPassword': false});
    }
    return false;
  }

  void goToLogin() {
    Get.toNamed(AppRoutes.loginScreen);
  }
}
