import 'package:get/get.dart';
import './account_screen_controller.dart';

class AccountScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AccountScreenController());
    }
}