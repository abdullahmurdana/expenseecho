// app_links_handler.dart
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:expenseecho/routes/app_routes.dart';

class AppLinksHandler {
  final AppLinks _appLinks = AppLinks();

  void init() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.path == '/reset-password') {
        final token = uri.queryParameters['token'];
        if (token != null) {
          Get.toNamed(AppRoutes.resetPasswordScreen, arguments: token);
        }
      }
    });
  }
}
