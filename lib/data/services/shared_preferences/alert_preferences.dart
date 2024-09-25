import 'package:shared_preferences/shared_preferences.dart';

class AlertPreferences {
  static const String _expenseAlertKey = 'expense_alert';
  static const String _budgetAlertKey = 'budget_alert';
  static const String _tipsArticlesKey = 'tips_articles';
  static const String _fcmToken = 'fcm_token';

  static Future<void> saveExpenseAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_expenseAlertKey, value);
  }

  static Future<bool?> getExpenseAlert() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_expenseAlertKey);
  }

  static Future<void> saveBudgetAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_budgetAlertKey, value);
  }

  static Future<bool?> getBudgetAlert() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_budgetAlertKey);
  }

  static Future<void> saveTipsArticles(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tipsArticlesKey, value);
  }

  static Future<bool?> getTipsArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_tipsArticlesKey);
  }

  static Future<void> saveFCMToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmToken, token);
    print("---> SP Handler :: FCM token Saved ::");
  }

  static Future<String?> getFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmToken);
  }

  static Future<void> clearFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmToken);
  }
}
