import 'package:get/get.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class SettingsThemeScreenController extends GetxController {
  var selectedTheme = 'Light'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedTheme();
  }

  Future<void> loadSelectedTheme() async {
    final theme = await SharedPreferencesHandler.getTheme();
    if (theme != null) {
      selectedTheme.value = theme;
    }
  }

  Future<void> selectTheme(String theme) async {
    selectedTheme.value = theme;
    await SharedPreferencesHandler.saveTheme(theme);
  }

  Future<List<String>> getThemes() async {
    return ['Light', 'Dark', 'System'];
  }
}
