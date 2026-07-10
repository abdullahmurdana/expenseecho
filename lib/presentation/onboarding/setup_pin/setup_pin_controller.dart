import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/database_handler.dart';
import 'package:expenseecho/presentation/onboarding/setup_account/setup_account_screen.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:get/get.dart';

class SetupPinController extends GetxController {
  var otp = ''.obs;
  var confirmedPin = ''.obs;
  var isConfirming = false.obs;
  var verifyPin = false.obs;
  var attempts = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    verifyPin.value = Get.arguments['verifyPin'] ?? false;
  }

  void addDigit(int digit) {
    if (otp.value.length < 4) {
      otp.value += digit.toString();
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
        await _verifyPin();
      } else {
        await _setupPin();
      }
      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error', 'Please enter a 4-digit PIN.');
    }
  }

  Future<void> _verifyPin() async {
    final savedPin = await UserPreferences.getPin();
    if (otp.value == savedPin) {
      Get.offNamed(AppRoutes.mainScreenHome);
    } else {
      attempts.value++;
      if (attempts.value >= 3) {
        await UserPreferences.clearAllUserData();
        Get.offAllNamed(AppRoutes.onboardingScreen);
      } else {
        Get.snackbar('Error', 'Incorrect PIN. Try again.');
      }
    }
  }

  Future<void> _setupPin() async {
    if (isConfirming.value) {
      confirmedPin.value = otp.value;
      if (await UserPreferences.getPin() == null) {
        await UserPreferences.savePin(confirmedPin.value);
        await _checkUserAccounts();
      } else {
        if (await UserPreferences.getPin() == confirmedPin.value) {
          await _checkUserAccounts();
        } else {
          Get.snackbar('Error', 'PINs do not match. Try again.');
          isConfirming.value = false;
        }
      }
    } else {
      isConfirming.value = true;
      otp.value = '';
    }
  }

  Future<void> _checkUserAccounts() async {
    // Check if the user has any accounts associated
    UserModel? userModel;
    await UserPreferences.getUserData().then((user) {
      if (user != null) {
        userModel = user;
      }
    });
    final accounts =
        await AccountHandler().getAccountsByUserId(userId: userModel?.id ?? '');
    if (accounts != null && accounts.isNotEmpty) {
      Get.offNamed(AppRoutes.mainScreenHome);
    } else {
      Get.off(() => SetupAccountScreen(userModel: userModel!));
    }
  }
}
