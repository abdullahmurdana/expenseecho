import 'package:get/get.dart';
import './sign_up_screen_controller.dart';

class SignUpScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SignUpScreenController());
    }
}