import 'package:get/get.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';

class SetupPinController extends GetxController {
  var otp = ''.obs; // Stores the entered PIN
  var confirmedPin = ''.obs; // Stores the confirmed PIN during setup
  var isConfirming = false.obs; // Indicates if the user is in confirmation mode
  var verifyPin = false.obs; // Indicates if we are verifying an existing PIN
  var attempts = 0.obs; // Number of failed attempts
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    verifyPin.value = Get.arguments['verifyPin'] ?? false;
  }

  void addDigit(int digit) {
    if (otp.value.length < 4) {
      otp.value += digit.toString();
      // Optionally, you can automatically submit OTP here if needed
      // if (otp.value.length == 4) {
      //   submitOtp();
      // }
    }
  }

  void removeLastDigit() {
    if (otp.value.isNotEmpty) {
      otp.value = otp.value.substring(0, otp.value.length - 1);
    }
  }

  Future<void> submitOtp() async {
    if (otp.value.length == 4) {
      isLoading.value = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );
      if (verifyPin.value) {
        final savedPin = await SharedPreferencesHandler.getPin();
        if (otp.value == savedPin) {
          Get.offNamed(AppRoutes.mainScreen);
        } else {
          attempts.value++;
          if (attempts.value >= 3) {
            await SharedPreferencesHandler.clearUserData();
            Get.offAllNamed(AppRoutes.onboardingScreen);
          } else {
            Get.snackbar('Error', 'Incorrect PIN. Try again.');
          }
        }
      } else {
        if (isConfirming.value) {
          confirmedPin.value = otp.value;
          if (await SharedPreferencesHandler.getPin() == null) {
            await SharedPreferencesHandler.savePin(confirmedPin.value);
            Get.offNamed(AppRoutes.mainScreen);
          } else {
            if (await SharedPreferencesHandler.getPin() == confirmedPin.value) {
              Get.offNamed(AppRoutes.mainScreen);
            } else {
              Get.snackbar('Error', 'PINs do not match. Try again.');
              isConfirming.value = false;
            }
          }
        } else {
          // Prepare for confirmation
          isConfirming.value = true;
          otp.value = ''; // Clear OTP for confirmation
        }
      }
      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error', 'Please enter a 4-digit PIN.');
    }
  }
}
