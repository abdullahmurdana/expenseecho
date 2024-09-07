import 'package:get/get.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class SettingsSecurityScreenController extends GetxController {
  var selectedSecurity = 'PIN'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedSecurity();
  }

  Future<void> loadSelectedSecurity() async {
    final security = await SharedPreferencesHandler.getSecurity();
    if (security != null) {
      selectedSecurity.value = security;
    }
  }

  Future<void> selectSecurity(String security) async {
    selectedSecurity.value = security;
    await SharedPreferencesHandler.saveSecurity(security);
  }

  Future<List<String>> getSecurities() async {
    return ['PIN', 'Biometric'];
  }
}
