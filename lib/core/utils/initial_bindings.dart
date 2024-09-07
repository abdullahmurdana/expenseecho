import 'package:expenseecho/core/app_exports.dart';
import 'package:expenseecho/presentation/onboarding/add_new_account/add_new_account_controller.dart';
import 'package:expenseecho/presentation/onboarding/forgot_screen/forgot_screen_controller.dart';
import 'package:expenseecho/presentation/onboarding/launch_screen/launch_screen_controller.dart';
import 'package:expenseecho/presentation/onboarding/login_screen/login_screen_controller.dart';
import 'package:expenseecho/presentation/onboarding/onboarding/onboarding_controller.dart';
import 'package:expenseecho/presentation/onboarding/reset_password_screen/reset_password_screen_controller.dart';
import 'package:expenseecho/presentation/onboarding/setup_account/setup_account_controller.dart';
import 'package:expenseecho/presentation/onboarding/setup_pin/setup_pin_controller.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_screen/sign_up_screen_controller.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_success/sign_up_success_controller.dart';
import 'package:expenseecho/presentation/onboarding/email_verification_screen/email_verification_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.lazyPut(() => LaunchScreenController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => SignUpScreenController(), fenix: true);
    Get.lazyPut(() => EmailVerificationController(), fenix: true);
    Get.lazyPut(() => LoginScreenController(), fenix: true);
    Get.lazyPut(() => ForgotScreenController(), fenix: true);
    Get.lazyPut(() => SetupPinController(), fenix: true);
    Get.lazyPut(() => SetupAccountController(), fenix: true);
    Get.lazyPut(() => AddNewAccountController(), fenix: true);
    Get.lazyPut(() => SignUpSuccessController(), fenix: true);
    Get.lazyPut(() => ResetPasswordScreenController(), fenix: true);
  }
}
