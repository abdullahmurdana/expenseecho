import 'package:get/get.dart';
import './settings_language_screen_controller.dart';

class SettingsLanguageScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsLanguageScreenController());
    }
}