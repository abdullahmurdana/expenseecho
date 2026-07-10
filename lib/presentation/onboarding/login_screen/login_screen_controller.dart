import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/handlers/user_db_handler.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var authToken = ''.obs;
  var isLoading = false.obs;

  Future<bool> signIn({required String email, required String password}) async {
    isLoading.value = true;
    try {
      UserModel? userModel =
          await UserHandler().signIn(email: email, password: password);

      // Save auth token and user data
      await UserPreferences.saveUserData(userModel!);
      await UserPreferences.setUserSignedIn(true);
      // await UserPreferences.saveAuthToken(token);

      // authToken.value = token;
      // print("---> Login Controller :: Auth token :: ${authToken.value}");
      return true;
    } catch (e) {
      print("---> Login Controller :: Sign in failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
