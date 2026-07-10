import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  void markAllAsRead() {
    // Implement your logic to mark all notifications as read
    Get.snackbar('Success', 'All notifications marked as read.');
  }

  void deleteAll() {
    // Implement your logic to delete all notifications
    Get.snackbar('Success', 'All notifications deleted.');
  }
}
