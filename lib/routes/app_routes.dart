import 'package:expenseecho/presentation/budgets/budget_empty_state/budget_empty_state_screen.dart';
import 'package:expenseecho/presentation/budgets/budget_list_view/budget_list_view_screen.dart';
import 'package:expenseecho/presentation/home/home_screen/home_screen.dart';
import 'package:expenseecho/presentation/home/main_screen/main_screen.dart';
import 'package:expenseecho/presentation/home/notification_screen/notification_screen.dart';
import 'package:expenseecho/presentation/onboarding/email_verification_screen/email_verification_screen.dart';
import 'package:expenseecho/presentation/onboarding/forgot_screen/forgot_screen.dart';
import 'package:expenseecho/presentation/onboarding/launch_screen/launch_screen.dart';
import 'package:expenseecho/presentation/onboarding/login_screen/login_screen.dart';
import 'package:expenseecho/presentation/onboarding/onboarding/onboarding_screen.dart';
import 'package:expenseecho/presentation/onboarding/reset_password_screen/reset_password_screen.dart';
import 'package:expenseecho/presentation/onboarding/setup_pin/setup_pin_screen.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_screen/sign_up_screen.dart';
import 'package:expenseecho/presentation/onboarding/sign_up_success/sign_up_success_screen.dart';
import 'package:expenseecho/presentation/profile/accounts/account_screen/account_screen.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_screen/export_data_screen.dart';
import 'package:expenseecho/presentation/profile/export_data/export_data_success/export_data_success_screen.dart';
import 'package:expenseecho/presentation/profile/profile_screen/profile_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_currency_screen/settings_currency_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_language_screen/settings_language_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_notifications_screen/settings_notifications_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_screen/settings_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_security_screen/settings_security_screen.dart';
import 'package:expenseecho/presentation/profile/settings/settings_theme_screen/settings_theme_screen.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_report_details/financial_report_details_screen.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_screen/financial_story_screen.dart';
import 'package:expenseecho/presentation/transactions/transactions_screen/transactions_screen.dart';
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
  static const String mainScreenHome = '/main_screen';
  static const String mainScreenTransactions = '/main_screen';
  static const String mainScreenBudgets = '/main_screen';
  static const String mainScreenProfile = '/main_screen';
  static const String notificationScreen = '/notification_screen';
  static const String transferAddNewScreen = '/transfer_add_new_screen';
  static const String transactionScreen = '/transaction_screen';
  static const String financialStoryScreen = '/financial_story_screen';
  static const String financialReportDetailsScreen =
      '/financial_report_details_screen';
  static const String budgetEmptyStateScreen = '/budget_empty_state_screen';
  static const String budgetCreateNewScreen = '/budget_create_new_screen';
  static const String budgetListViewScreen = '/budget_list_view_screen';

  static List<GetPage> getPages = [
    GetPage(
      name: initialRoute,
      page: () => const LaunchScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: mainScreenHome,
      page: () => const MainScreen(
        index: 0,
      ),
    ),
    GetPage(
      name: mainScreenTransactions,
      page: () => const MainScreen(
        index: 1,
      ),
    ),
    GetPage(
      name: mainScreenBudgets,
      page: () => const MainScreen(
        index: 2,
      ),
    ),
    GetPage(
      name: mainScreenProfile,
      page: () => const MainScreen(
        index: 3,
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
      name: notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: transactionScreen,
      page: () => const TransactionsScreen(),
    ),
    GetPage(
      name: financialStoryScreen,
      page: () => const FinancialStoryScreen(),
    ),
    GetPage(
      name: financialReportDetailsScreen,
      page: () => const FinancialReportDetailsScreen(),
    ),
    GetPage(
      name: budgetEmptyStateScreen,
      page: () => const BudgetEmptyStateScreen(),
    ),
    GetPage(
      name: budgetListViewScreen,
      page: () => const BudgetListViewScreen(),
    ),
  ];
}
