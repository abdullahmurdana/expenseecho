import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:expenseecho/core/utils/initial_bindings.dart';
import 'package:expenseecho/core/utils/theme_manager.dart';
import 'package:expenseecho/data/models/language/language_model.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';
import 'package:expenseecho/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Save the list of currencies to SharedPreferences
  /*await SharedPreferencesHandler.removeCurrencies();
  await SharedPreferencesHandler.saveCurrencies(currencies);*/

  // Remove user data from SharedPreferences
  // await SharedPreferencesHandler.clearAllUserData();

  // Save the list of currencies to SharedPreferences
  /*await SettingsHandler.removeLanguages();
  await SettingsHandler.saveLanguages(languages);*/

  // Save the list of expense/income category to SharedPreferences
  /*await SharedPreferencesHandler.removeCategories();
  await SharedPreferencesHandler.saveExpenseCategories(majorExpenseCategories);
  await SharedPreferencesHandler.saveIncomeCategories(majorIncomeCategories);*/

  // Load the selected language from SharedPreferences
  LanguageModel? selectedLanguage =
      await SharedPreferencesHandler.getSelectedLanguage();
  Locale initialLocale = selectedLanguage != null
      ? Locale(selectedLanguage.locale)
      : const Locale('en');

  runApp(MainApp(initialLocale: initialLocale));
}

class MainApp extends StatelessWidget {
  final Locale initialLocale;

  const MainApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return GetMaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              locale: initialLocale,
              fallbackLocale: const Locale('en'),
              title: 'Expense Echo',
              initialRoute: AppRoutes.initialRoute,
              getPages: AppRoutes.getPages,
              initialBinding: InitialBindings(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.themeMode,
            );
          },
        ));
  }
}
