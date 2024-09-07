import 'package:get/get.dart';
import './export_data_success_controller.dart';

class ExportDataSuccessBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ExportDataSuccessController());
    }
}