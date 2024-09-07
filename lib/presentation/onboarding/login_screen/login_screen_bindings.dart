import 'package:get/get.dart';
import './login_screen_controller.dart';

class LoginScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginScreenController(), permanent: true);
  }
}
