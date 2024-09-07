import 'package:get/get.dart';
import './settings_currency_screen_controller.dart';

class SettingsCurrencyScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsCurrencyScreenController());
    }
}