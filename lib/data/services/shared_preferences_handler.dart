import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHandler {
  static const String _selectedCurrencyKey = 'selected_currency';
  static const String _currenciesListKey = 'currencies_list';
  static const String _themeKey = 'theme';
  static const String _securityKey = 'security';
  static const String _selectedLanguageKey = 'selected_language';
  static const String _languagesListKey = 'languages_list';
  static const String _userKey = 'current_user';
  static const String _userPinKey = 'user_pin';
  static const String _userSignedInKey = 'user_signed_in';
  static const String _authTokenKey = 'auth_token';
  static const String _expenseAlertKey = 'expense_alert';
  static const String _budgetAlertKey = 'budget_alert';
  static const String _tipsArticlesKey = 'tips_articles';
  static const String _expenseCategoriesKey = 'expense_categories';
  static const String _incomeCategoriesKey = 'income_categories';

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
}
