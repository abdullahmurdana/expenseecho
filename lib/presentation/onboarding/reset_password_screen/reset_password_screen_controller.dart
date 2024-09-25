import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:get/get.dart';

class ResetPasswordScreenController extends GetxController {
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var token = ''.obs;

  Future<void> resetPassword() async {
    if (newPassword.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      await AuthAPIService.resetPassword(token.value, newPassword.value);
      Get.snackbar('Success', 'Password reset successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
