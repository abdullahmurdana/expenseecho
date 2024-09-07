import 'package:get/get.dart';
import './settings_notifications_screen_controller.dart';

class SettingsNotificationsScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SettingsNotificationsScreenController());
    }
}