import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:get/get.dart';

class SettingsThemeScreenController extends GetxController {
  var selectedTheme = 'Light'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedTheme();
  }

  Future<void> loadSelectedTheme() async {
    final theme = await ThemePreferences.getTheme();
    if (theme != null) {
      selectedTheme.value = theme;
    }
  }

  Future<void> selectTheme(String theme) async {
    selectedTheme.value = theme;
    await ThemePreferences.saveTheme(theme);
  }

  Future<List<String>> getThemes() async {
    return ['Light', 'Dark', 'System'];
  }
}
