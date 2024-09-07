import 'package:get/get.dart';
import './profile_screen_controller.dart';

class ProfileScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ProfileScreenController());
    }
}