import 'package:get/get.dart';
import './settings_security_screen_controller.dart';

class SettingsSecurityScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsSecurityScreenController());
    }
}