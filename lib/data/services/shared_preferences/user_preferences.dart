import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:expenseecho/data/models/user_model/user_model.dart';

class UserPreferences {
  static const String _authTokenKey = 'auth_token';
  static const String _userKey = 'current_user';
  static const String _userPinKey = 'user_pin';
  static const String _userSignedInKey = 'user_signed_in';

  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    print("---> UserPreferences :: Auth token Saved ::");
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
    print("---> UserPreferences :: saved user data...");
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
    print("---> UserPreferences :: saved PIN");
  }

  static Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPinKey);
  }

  static Future<void> clearPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPinKey);
    print("---> UserPreferences :: cleared PIN");
  }

  static Future<void> setUserSignedIn(bool signedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userSignedInKey, signedIn);
    print("---> UserPreferences :: set (User Sign in)");
  }

  static Future<bool> isUserSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userSignedInKey) ?? false;
  }

  static Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userSignedInKey);
    await prefs.remove(_userPinKey);
    await prefs.remove(_userKey);
    print("---> UserPreferences :: Clearing all user Data...");
  }
}
