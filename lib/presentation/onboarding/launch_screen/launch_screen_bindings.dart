import 'package:get/get.dart';
import './launch_screen_controller.dart';

class LaunchScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LaunchScreenController(), fenix: true);
  }
}
