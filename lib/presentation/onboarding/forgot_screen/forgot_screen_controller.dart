import 'package:get/get.dart';
import 'package:expenseecho/data/services/api_service_http.dart';

class ForgotScreenController extends GetxController {
  var email = ''.obs;

  Future<void> sendResetEmail() async {
    try {
      await ApiServiceHttp.sendResetEmail(email.value);
      Get.snackbar('Success', 'Reset email sent');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
