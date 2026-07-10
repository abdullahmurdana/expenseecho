import '../core/barrel_files/packages_export.dart';
import '../core/barrel_files/screen_exports.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onboardingLaunchScreen = '/onboarding_launch_screen';
  static const String onboardingScreen = '/onboarding_screen';

  // static const String emailVerificationScreen = '/email_verification_screen';
  static const String signupScreen = '/signup_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotScreen = '/forgot_screen';
  static const String setupPinScreen = '/setup_pin_screen';
  static const String signupSuccessScreen = '/signup_success_screen';

  // static const String resetPasswordScreen = '/reset_password_screen';
  static const String profileScreen = '/profile_screen';
  static const String profileEditScreen = '/profile_edit_screen';
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
  static const String settingsBackgroundSyncScreen =
      '/settings_background_sync_screen';
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
      page: () => const MainScreen(),
    ),
    GetPage(
      name: mainScreenTransactions,
      page: () {
        return const MainScreen();
      },
    ),
    GetPage(
      name: mainScreenBudgets,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: mainScreenProfile,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: signupScreen,
      page: () => const SignUpScreen(),
    ),
    // GetPage(
    //   name: emailVerificationScreen,
    //   page: () => const EmailVerificationScreen(),
    // ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: forgotScreen,
      page: () => const ForgotScreen(),
    ),
    // GetPage(
    //   name: resetPasswordScreen,
    //   page: () => const ResetPasswordScreen(),
    // ),
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
      name: profileEditScreen,
      page: () => const ProfileEditScreen(),
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
      name: settingsBackgroundSyncScreen,
      page: () => const SettingsBackgroundSyncScreen(),
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
