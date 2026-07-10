import 'dart:convert';
import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;

class AuthAPIService {
  static Future<Map<String, dynamic>> signInHttp({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.baseUrl}/api/collections/users/auth-with-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"identity": identity, "password": password}),
      );

      print("---> API Service :: Response Code :: ${response.statusCode}");
      print("---> API Service :: Response reason  :: ${response.reasonPhrase}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        throw Exception(
            '---> Failed to SignIn: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('---> Error during sign-in: $e');
      throw Exception('---> Error during sign-in');
    }
  }

  static Future<void> sendResetEmail(String email) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/password_resets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset email');
    }
  }

  static Future<void> resetPassword(String token, String newPassword) async {
    final response = await http.patch(
      Uri.parse('${Config.baseUrl}/api/password_resets/$token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"password": newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  static Future<void> addUserToQueue(UserModel userModel) async {
    await QueueManager().addTransactionToQueue('user', userModel.toMap());
  }
}
