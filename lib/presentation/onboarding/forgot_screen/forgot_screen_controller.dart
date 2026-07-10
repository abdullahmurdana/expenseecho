import 'package:expenseecho/data/services/api_service/api_service_handler.dart';
import 'package:get/get.dart';

class ForgotScreenController extends GetxController {
  var email = ''.obs;

  Future<void> sendResetEmail() async {
    try {
      await AuthAPIService.sendResetEmail(email.value);
      Get.snackbar('Success', 'Reset email sent');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
