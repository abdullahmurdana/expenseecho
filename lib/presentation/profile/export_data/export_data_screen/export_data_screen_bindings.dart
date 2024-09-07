import 'package:get/get.dart';
import './export_data_screen_controller.dart';

class ExportDataScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ExportDataScreenController());
    }
}