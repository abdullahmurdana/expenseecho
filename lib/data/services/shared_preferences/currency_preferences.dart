import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:expenseecho/data/models/currency/currency_model.dart';

class CurrencyPreferences {
  static const String _selectedCurrencyKey = 'selected_currency';
  static const String _currenciesListKey = 'currencies_list';

  static Future<void> saveSelectedCurrency(CurrencyModel currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCurrencyKey, jsonEncode(currency.toJson()));
  }

  static Future<CurrencyModel?> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final currencyString = prefs.getString(_selectedCurrencyKey);
    // print("---> Currency Data :: CurrencyPreferences :: ${currencyString.toString()}");

    if (currencyString != null && currencyString.isNotEmpty) {
      return CurrencyModel.fromJson(jsonDecode(currencyString));
    }
    return null;
  }

  static Future<void> saveCurrencies(List<CurrencyModel> currencies) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currencyStrings =
        currencies.map((currency) => jsonEncode(currency.toJson())).toList();
    await prefs.setStringList(_currenciesListKey, currencyStrings);
    print("---> saved new currencies");
  }

  static Future<List<CurrencyModel>> getCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? currencyStrings = prefs.getStringList(_currenciesListKey);
    if (currencyStrings != null) {
      return currencyStrings
          .map((currencyString) =>
              CurrencyModel.fromJson(jsonDecode(currencyString)))
          .toList();
    }
    print("---> fetched currencies list");
    return [];
  }

  static Future<void> removeCurrencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currenciesListKey);
    print("---> removed currencies list");
  }
}
