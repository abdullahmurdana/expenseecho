import 'package:expenseecho/core/app_exports.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen_controller.dart';
import 'package:expenseecho/presentation/home/main_screen/main_screen_controller.dart';
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
import 'package:expenseecho/presentation/profile/account_screen/account_screen_controller.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_screen/export_data_screen_controller.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_success/export_data_success_controller.dart';
import 'package:expenseecho/presentation/profile/profile_screen/profile_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_currency_screen/settings_currency_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_language_screen/settings_language_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_notifications_screen/settings_notifications_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_screen/settings_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_security_screen/settings_security_screen_controller.dart';
import 'package:expenseecho/presentation/profile/settings/settings_theme_screen/settings_theme_screen_controller.dart';

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
    Get.lazyPut(() => ProfileScreenController(), fenix: true);
    Get.lazyPut(() => AccountScreenController(), fenix: true);
    Get.lazyPut(() => SettingsScreenController(), fenix: true);
    Get.lazyPut(() => SettingsCurrencyScreenController(), fenix: true);
    Get.lazyPut(() => SettingsThemeScreenController(), fenix: true);
    Get.lazyPut(() => SettingsLanguageScreenController(), fenix: true);
    Get.lazyPut(() => SettingsSecurityScreenController(), fenix: true);
    Get.lazyPut(() => SettingsNotificationsScreenController(), fenix: true);
    Get.lazyPut(() => ExportDataScreenController(), fenix: true);
    Get.lazyPut(() => ExportDataSuccessController(), fenix: true);
    Get.lazyPut(() => HomeScreenController(), fenix: true);
    Get.lazyPut(() => MainScreenController(), fenix: true);
  }
}
