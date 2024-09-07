import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class ProfileScreenController extends GetxController {
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userData = await SharedPreferencesHandler.getUserData();
    if (userData != null) {
      user.value = userData;
    } else {
      print('No user data found.');
    }
  }
}
