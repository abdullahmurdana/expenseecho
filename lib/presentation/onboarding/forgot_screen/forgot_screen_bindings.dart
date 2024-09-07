import 'package:get/get.dart';
import './forgot_screen_controller.dart';

class ForgotScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ForgotScreenController());
    }
}