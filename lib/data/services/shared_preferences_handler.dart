import 'package:expenseecho/data/models/category_model.dart';
import 'package:expenseecho/data/models/currency/currency_model.dart';
import 'package:expenseecho/data/models/language/language_model.dart';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHandler {
  static const String _authTokenKey = 'auth_token';
  static const String _budgetAlertKey = 'budget_alert';
  static const String _currenciesListKey = 'currencies_list';
  static const String _expenseAlertKey = 'expense_alert';
  static const String _expenseCategoriesKey = 'expense_categories';
  static const String _incomeCategoriesKey = 'income_categories';
  static const String _languagesListKey = 'languages_list';
  static const String _securityKey = 'security';
  static const String _selectedCurrencyKey = 'selected_currency';
  static const String _selectedLanguageKey = 'selected_language';
  static const String _themeKey = 'theme';
  static const String _tipsArticlesKey = 'tips_articles';
  static const String _userKey = 'current_user';
  static const String _userPinKey = 'user_pin';
  static const String _userSignedInKey = 'user_signed_in';

  // User related
  static Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userSignedInKey);
    await prefs.remove(_userPinKey);
    await prefs.remove(_userKey);
    print("---> Clearing all user Data...");
  }

  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    print("---> SP Handler :: Auth token Saved ::");
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }

  static Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toMap()));
    print("---> SP handler :: saved user data...");
  }

  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromMap(userMap);
    }
    return null;
  }

  static Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPinKey, pin);
    print("---> SP Handler :: saved PIN");
  }

  static Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPinKey);
  }

  static Future<void> clearPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPinKey);
    print("---> SP Handler :: cleared PIN");
  }

  static Future<void> setUserSignedIn(bool signedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userSignedInKey, signedIn);
    print("---> SP Handler :: set (User Sign in)");
  }

  static Future<bool> isUserSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userSignedInKey) ?? false;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPinKey);
    await prefs.remove(_userKey);
    await prefs.remove(_userSignedInKey);
    await prefs.remove(_authTokenKey);
  }

  // Save theme to SharedPreferences
  static Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  // Get theme from SharedPreferences
  static Future<String?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }

  // Save Expense Alert to SharedPreferences
  static Future<void> saveExpenseAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_expenseAlertKey, value);
  }

  // Get Expense Alert from SharedPreferences
  static Future<bool?> getExpenseAlert() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_expenseAlertKey);
  }

  // Save Budget Alert to SharedPreferences
  static Future<void> saveBudgetAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_budgetAlertKey, value);
  }

  // Get Budget Alert from SharedPreferences
  static Future<bool?> getBudgetAlert() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_budgetAlertKey);
  }

  // Save Tips & Articles to SharedPreferences
  static Future<void> saveTipsArticles(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tipsArticlesKey, value);
  }

  // Get Tips & Articles from SharedPreferences
  static Future<bool?> getTipsArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_tipsArticlesKey);
  }

  // Save Security to SharedPreferences
  static Future<void> saveSecurity(String security) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_securityKey, security);
  }

  // Get Security from SharedPreferences
  static Future<String?> getSecurity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_securityKey);
  }

  // Save selected currency to SharedPreferences
  static Future<void> saveSelectedCurrency(CurrencyModel currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCurrencyKey, jsonEncode(currency.toJson()));
  }

  // Get selected currency from SharedPreferences
  static Future<CurrencyModel?> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final currencyString = prefs.getString(_selectedCurrencyKey);
    print("---> Currency Data :: SP Handler :: ${currencyString.toString()}");

    if (currencyString != null && currencyString.isNotEmpty) {
      return CurrencyModel.fromJson(jsonDecode(currencyString));
    }
    return null;
  }

  // Save list of currencies to SharedPreferences
  static Future<void> saveCurrencies(List<CurrencyModel> currencies) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currencyStrings =
        currencies.map((currency) => jsonEncode(currency.toJson())).toList();
    await prefs.setStringList(_currenciesListKey, currencyStrings);
    print("---> saved new currencies");
  }

  // Get list of currencies from SharedPreferences
  static Future<List<CurrencyModel>> getCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? currencyStrings = prefs.getStringList(_currenciesListKey);
    if (currencyStrings != null) {
      return currencyStrings
          .map((currencyString) =>
              CurrencyModel.fromJson(jsonDecode(currencyString)))
          .toList();
    }
    print("---> fetched currencies list");
    return [];
  }

  // Remove the List from shared preferences
  static Future<void> removeCurrencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currenciesListKey);
    print("---> removed currencies list");
  }

  // Save selected language to SharedPreferences
  static Future<void> saveSelectedLanguage(LanguageModel language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageKey, jsonEncode(language.toJson()));
  }

  // Get selected language from SharedPreferences
  static Future<LanguageModel?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageString = prefs.getString(_selectedLanguageKey);
    if (languageString != null) {
      return LanguageModel.fromJson(jsonDecode(languageString));
    }
    return null;
  }

  // Save list of languages to SharedPreferences
  static Future<void> saveLanguages(List<LanguageModel> languages) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> languageStrings =
        languages.map((language) => jsonEncode(language.toJson())).toList();
    await prefs.setStringList(_languagesListKey, languageStrings);
  }

  // Get list of languages from SharedPreferences
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

  /// Remove the List from shared preferences
  static Future<void> removeLanguages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languagesListKey);
    print("---> removed languages list");
  }

  // Save income categories to shared preferences
  static Future<void> saveIncomeCategories(
      List<CategoryModel> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson =
        categories.map((category) => json.encode(category.toMap())).toList();
    await prefs.setStringList(_incomeCategoriesKey, categoriesJson);
    print("---> Saved income categories...");
  }

// Load income categories from shared preferences
  static Future<List<CategoryModel>> loadIncomeCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList(_incomeCategoriesKey);
    if (categoriesJson == null) {
      return [];
    }
    return categoriesJson
        .map((categoryJson) => CategoryModel.fromMap(json.decode(categoryJson)))
        .toList();
  }

// Save a single income category to shared preferences
  static Future<void> saveIncomeCategory(CategoryModel category) async {
    List<CategoryModel> categories = await loadIncomeCategories();
    categories.add(category);
    await saveIncomeCategories(categories);
  }

// Save expense categories to shared preferences
  static Future<void> saveExpenseCategories(
      List<CategoryModel> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson =
        categories.map((category) => json.encode(category.toMap())).toList();
    await prefs.setStringList(_expenseCategoriesKey, categoriesJson);
    print("---> Saved expense categories...");
  }

  // Remove the List from shared preferences
  static Future<void> removeCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_expenseCategoriesKey);
    print("---> removed expense Categories list");
    await prefs.remove(_incomeCategoriesKey);
    print("---> removed income Categories list");
  }

// Load expense categories from shared preferences
  static Future<List<CategoryModel>> loadExpenseCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList(_expenseCategoriesKey);
    if (categoriesJson == null) {
      return [];
    }
    return categoriesJson
        .map((categoryJson) => CategoryModel.fromMap(json.decode(categoryJson)))
        .toList();
  }

// Save a single expense category to shared preferences
  static Future<void> saveExpenseCategory(CategoryModel category) async {
    List<CategoryModel> categories = await loadExpenseCategories();
    categories.add(category);
    await saveExpenseCategories(categories);
  }
}
