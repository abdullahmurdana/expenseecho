import 'package:shared_preferences/shared_preferences.dart';

class SecurityPreferences {
  static const String _securityKey = 'security';
  static Future<void> saveSecurity(String security) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_securityKey, security);
  }

  // Get Security from SharedPreferences
  static Future<String?> getSecurity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_securityKey);
  }
}
