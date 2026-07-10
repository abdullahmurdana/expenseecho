import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:get/get.dart';

class LaunchScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    // Get.toNamed(AppRoutes.mainScreenHome);
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    final isUserSignedIn = await UserPreferences.isUserSignedIn();
    UserModel? user = await UserPreferences.getUserData();
    print('---> User :: ${user.toString()}');
    print("---> Launch Screen Controller :: User Sign in :: $isUserSignedIn");
    if (isUserSignedIn) {
      final pin = await UserPreferences.getPin();
      print(
          "---> Launch Screen Controller :: PIN Available :: ${pin?.isNotEmpty}");
      if (pin != null) {
        Get.offNamed(AppRoutes.setupPinScreen, arguments: {'verifyPin': true});
      } else {
        Get.offNamed(AppRoutes.setupPinScreen, arguments: {'verifyPin': false});
      }
    } else {
      Get.offNamed(AppRoutes.onboardingScreen);
    }
  }
}
