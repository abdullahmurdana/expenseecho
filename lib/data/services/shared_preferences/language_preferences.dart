import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:expenseecho/data/models/language/language_model.dart';

class LanguagePreferences {
  static const String _selectedLanguageKey = 'selected_language';
  static const String _languagesListKey = 'languages_list';

  static Future<void> saveSelectedLanguage(LanguageModel language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageKey, jsonEncode(language.toJson()));
  }

  static Future<LanguageModel?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageString = prefs.getString(_selectedLanguageKey);
    if (languageString != null) {
      return LanguageModel.fromJson(jsonDecode(languageString));
    }
    return null;
  }

  static Future<void> saveLanguages(List<LanguageModel> languages) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> languageStrings =
        languages.map((language) => jsonEncode(language.toJson())).toList();
    await prefs.setStringList(_languagesListKey, languageStrings);
  }

  static Future<List<LanguageModel>> getLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? languageStrings = prefs.getStringList(_languagesListKey);
    if (languageStrings != null) {
      return languageStrings
          .map((languageString) =>
              LanguageModel.fromJson(jsonDecode(languageString)))
          .toList();
    }
    return [];
  }

  static Future<void> removeLanguages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languagesListKey);
    print("---> removed languages list");
  }
}
