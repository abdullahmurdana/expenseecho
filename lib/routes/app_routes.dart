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
  ];
}
