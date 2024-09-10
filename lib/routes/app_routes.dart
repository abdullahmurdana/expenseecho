import 'package:expenseecho/presentation/expenses/expense_add_new/expense_add_new_screen.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen.dart';
import 'package:expenseecho/presentation/home/main_screen/main_screen.dart';
import 'package:expenseecho/presentation/onboarding/add_new_account/add_new_account_screen.dart';
import 'package:expenseecho/presentation/onboarding/forgot_screen/forgot_screen.dart';
import 'package:expenseecho/presentation/onboarding/launch_screen/launch_screen.dart';
import 'package:expenseecho/presentation/onboarding/login_screen/login_screen.dart';
import 'package:expenseecho/presentation/onboarding/onboarding/onboarding_screen.dart';
import 'package:expenseecho/presentation/onboarding/reset_password_screen/reset_password_screen.dart';
import 'package:expenseecho/presentation/onboarding/setup_account/setup_account_screen.dart';
import 'package:expenseecho/presentation/onboarding/setup_pin/setup_pin_screen.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_screen/sign_up_screen.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_success/sign_up_success_screen.dart';
import 'package:expenseecho/presentation/onboarding/email_verification_screen/email_verification_screen.dart';
import 'package:expenseecho/presentation/profile/account_screen/account_screen.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_screen/export_data_screen.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_success/export_data_success_screen.dart';
import 'package:expenseecho/presentation/profile/profile_screen/profile_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_currency_screen/settings_currency_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_language_screen/settings_language_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_notifications_screen/settings_notifications_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_screen/settings_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_security_screen/settings_security_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_theme_screen/settings_theme_screen.dart';
import 'package:expenseecho/presentation/transfers/transfer_add_new/transfer_add_new_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onboardingLaunchScreen = '/onboarding_launch_screen';
  static const String onboardingScreen = '/onboarding_screen';
  static const String emailVerificationScreen = '/email_verification_screen';
  static const String signupScreen = '/signup_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotScreen = '/forgot_screen';
  static const String setupPinScreen = '/setup_pin_screen';
  static const String setupAccountScreen = '/setup_account_screen';
  static const String addNewAccountScreen = '/add_new_account_screen';
  static const String signupSuccessScreen = '/signup_success_screen';
  static const String resetPasswordScreen = '/reset_password_screen';
  static const String profileScreen = '/profile_screen';
  static const String accountScreen = '/account_screen';
  static const String settingsScreen = '/settings_screen';
  static const String settingsCurrencyScreen = '/settings_currency_screen';
  static const String settingsLanguageScreen = '/settings_language_screen';
  static const String settingsThemeScreen = '/settings_theme_screen';
  static const String settingsSecurityScreen = '/settings_security_screen';
  static const String exportDataScreen = '/export_data_screen';
  static const String exportDataSuccessScreen = '/export_data_success_screen';
  static const String settingsNotificationsScreen =
      '/settings_notification_screen';
  static const String homeScreen = '/home_screen';
  static const String mainScreen = '/main_screen';
  static const String transferAddNewScreen = '/transfer_add_new_screen';
  static const String expenseAddNewScreen = '/expense_add_new_screen';

  static List<GetPage> getPages = [
    GetPage(
      name: initialRoute,
      page: () => const LaunchScreen(),
    ),
    // GetPage(
    //   name: onboardingLaunchScreen,
    //   page: () => const LaunchScreen(),
    // ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),

    GetPage(
      name: mainScreen,
      page: () => const MainScreen(
        index: 0,
      ),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: signupScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: emailVerificationScreen,
      page: () => const EmailVerificationScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: forgotScreen,
      page: () => const ForgotScreen(),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: setupPinScreen,
      page: () => const SetupPinScreen(),
    ),
    GetPage(
      name: setupAccountScreen,
      page: () => const SetupAccountScreen(),
    ),
    GetPage(
      name: addNewAccountScreen,
      page: () => const AddNewAccountScreen(),
    ),
    GetPage(
      name: signupSuccessScreen,
      page: () => const SignUpSuccessScreen(),
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: accountScreen,
      page: () => const AccountScreen(),
    ),
    GetPage(
      name: settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: settingsCurrencyScreen,
      page: () => const SettingsCurrencyScreen(),
    ),
    GetPage(
      name: settingsLanguageScreen,
      page: () => const SettingsLanguageScreen(),
    ),
    GetPage(
      name: settingsThemeScreen,
      page: () => const SettingsThemeScreen(),
    ),
    GetPage(
      name: settingsSecurityScreen,
      page: () => const SettingsSecurityScreen(),
    ),
    GetPage(
      name: settingsNotificationsScreen,
      page: () => const SettingsNotificationsScreen(),
    ),
    GetPage(
      name: exportDataScreen,
      page: () => const ExportDataScreen(),
    ),
    GetPage(
      name: exportDataSuccessScreen,
      page: () => const ExportDataSuccessScreen(),
    ),

    GetPage(
      name: transferAddNewScreen,
      page: () => const TransferAddnewScreen(),
    ),
    GetPage(
      name: expenseAddNewScreen,
      page: () => const ExpenseAddNewScreen(),
    ),
  ];
}
