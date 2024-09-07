import 'package:get/get.dart';
import './sign_up_success_controller.dart';

class SignUpSuccessBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SignUpSuccessController());
    }
}