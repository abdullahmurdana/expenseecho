import 'package:get/get.dart';
import './settings_theme_screen_controller.dart';

class SettingsThemeScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsThemeScreenController());
    }
}