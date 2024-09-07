import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:expenseecho/data/services/api_service_http.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class LoginScreenController extends GetxController {
  var authToken = ''.obs;
  var isLoading = false.obs;

  Future<bool> signIn({required String email, required String password}) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> responseJson =
          await ApiServiceHttp.signInHttp(identity: email, password: password);

      String token = responseJson['token'];
      var userData = responseJson['record'];
      var userModel = UserModel.fromMap(userData);

      // Save auth token and user data
      await SharedPreferencesHandler.saveUserData(userModel);
      await SharedPreferencesHandler.setUserSignedIn(true);
      await SharedPreferencesHandler.saveAuthToken(token);

      authToken.value = token;
      print("---> Login Controller :: Auth token :: ${authToken.value}");
      return true;
    } catch (e) {
      print("---> Login Controller :: Sign in failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
