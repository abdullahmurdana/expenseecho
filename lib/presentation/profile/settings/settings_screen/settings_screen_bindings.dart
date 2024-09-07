import 'package:get/get.dart';
import './settings_screen_controller.dart';

class SettingsScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsScreenController());
    }
}