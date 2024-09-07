import 'package:get/get.dart';
import 'package:expenseecho/data/models/currency/currency_model.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class SettingsCurrencyScreenController extends GetxController {
  var selectedCurrency = Rxn<CurrencyModel>();

  @override
  void onInit() {
    super.onInit();
    loadCurrency();
  }

  Future<void> loadCurrency() async {
    final currency = await SharedPreferencesHandler.getSelectedCurrency();
    // print(
    //     "---> Currency Data :: Currency Controller :: ${currency.toString()}");
    if (currency != null) {
      selectedCurrency.value = currency;
    } else {
      // Handle the case where no currency is selected
      selectedCurrency.value = CurrencyModel(
          shortForm: 'USD',
          fullName: "United States Dollar",
          symbol: '\$'); // or set a default value
    }
  }

  void selectCurrency(CurrencyModel currency) async {
    selectedCurrency.value = currency;
    await SharedPreferencesHandler.saveSelectedCurrency(currency);
  }

  Future<List<CurrencyModel>> getCurriences() async {
    List<CurrencyModel> currencies =
        await SharedPreferencesHandler.getCurrencies();
    return currencies;
  }
}
