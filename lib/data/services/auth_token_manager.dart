/* import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenManager {
  static const String _authTokenKey = 'auth_token';

  /// Save the auth token to shared preferences
  static Future<void> saveAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  /// Retrieve the auth token from shared preferences
  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  /// Remove the auth token from shared preferences
  static Future<void> removeAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }
}
 */