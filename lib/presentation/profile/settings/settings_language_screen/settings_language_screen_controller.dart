import 'dart:ui';

import 'package:expenseecho/data/models/language/language_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:get/get.dart';

class SettingsLanguageScreenController extends GetxController {
  var selectedLanguage = LanguageModel(name: 'English', locale: 'en').obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  void loadLanguage() async {
    LanguageModel? language = await LanguagePreferences.getSelectedLanguage();
    if (language != null) {
      selectedLanguage.value = language;
      Get.updateLocale(Locale(language.locale));
    }
  }

  void selectLanguage(LanguageModel language) async {
    selectedLanguage.value = language;
    await LanguagePreferences.saveSelectedLanguage(language);
    Get.updateLocale(Locale(language.locale));
  }

  Future<List<LanguageModel>> getLanguages() async {
    List<LanguageModel> languages = await LanguagePreferences.getLanguages();
    return languages;
  }
}
