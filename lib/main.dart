import 'package:expenseecho/core/utils/initial_bindings.dart';
import 'package:expenseecho/core/utils/theme_manager.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove user data from SharedPreferences
  // await SharedPreferencesHandler.clearAllUserData();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
              locale: const Locale('en'),
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
