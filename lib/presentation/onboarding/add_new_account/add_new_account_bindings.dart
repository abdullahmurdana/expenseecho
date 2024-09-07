import 'package:get/get.dart';
import './add_new_account_controller.dart';

class AddNewAccountBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AddNewAccountController());
    }
}