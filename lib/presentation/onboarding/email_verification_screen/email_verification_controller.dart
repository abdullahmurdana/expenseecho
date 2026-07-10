import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:get/get.dart';
import 'package:expenseecho/routes/app_routes.dart';

class EmailVerificationController extends GetxController {
  var otp = ''.obs; // Stores the entered OTP
  var isLoading =
      false.obs; // Indicates if the loading indicator should be shown
  var isResetPassword =
      false.obs; // Indicates if the screen is for reset password

  @override
  void onInit() {
    super.onInit();
    isResetPassword.value = Get.arguments['isResetPassword'] ?? false;
  }

  void addDigit(int digit) {
    if (otp.value.length < 6) {
      otp.value += digit.toString();
      if (otp.value.length == 6) {
        submitOtp();
      }
    }
  }

  void removeLastDigit() {
    if (otp.value.isNotEmpty) {
      otp.value = otp.value.substring(0, otp.value.length - 1);
    }
  }

  Future<void> submitOtp() async {
    if (otp.value.length == 6) {
      isLoading.value = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );

      if (isResetPassword.value) {
        // Navigate to reset password screen
        Get.offNamed(AppRoutes.resetPasswordScreen);
      } else {
        // Navigate to setup PIN screen
        final savedPin = await UserPreferences.getPin();
        if (savedPin == null) {
          Get.offNamed(AppRoutes.setupPinScreen,
              arguments: {'verifyPin': false});
        } else {
          Get.offNamed(AppRoutes.setupPinScreen,
              arguments: {'verifyPin': true});
          // Get.snackbar('Error', 'Email verification failed. Try again.');
        }
      }

      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error', 'Please enter a 4-digit OTP.');
    }
  }
}
