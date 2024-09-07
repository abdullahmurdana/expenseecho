import 'package:get/get.dart';
import './main_screen_controller.dart';

class MainScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(MainScreenController());
    }
}