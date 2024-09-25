import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  var user = Rxn<UserModel>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userData = await UserPreferences.getUserData();
    if (userData != null) {
      user.value = userData;
    } else {
      print('No user data found.');
    }
  }
}
