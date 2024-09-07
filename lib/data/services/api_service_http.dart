import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServiceHttp {
  static const String url = 'https://b6ca-59-103-219-14.ngrok-free.app';

  static Future<Map<String, dynamic>> signInHttp({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/api/collections/users/auth-with-password'),
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

  static sendResetEmail(String value) {}

  static resetPassword(String value, String value2) {}
}
