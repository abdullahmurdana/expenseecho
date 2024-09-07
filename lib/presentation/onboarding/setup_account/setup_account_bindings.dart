import 'package:get/get.dart';
import './setup_account_controller.dart';

class SetupAccountBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SetupAccountController());
    }
}