import 'package:expenseecho/core/utils/initial_bindings.dart';
import 'package:expenseecho/core/utils/theme_manager.dart';
import 'package:expenseecho/data/models/currency/currency_model.dart';
import 'package:expenseecho/data/models/language/language_model.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:expenseecho/data/services/shared_preferences/shared_preferences_handler.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';
import 'package:expenseecho/firebase_options.dart';
import 'package:expenseecho/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // * Initialize NotificationService
  // NotificationService();

  // *Initialize SQLite and QueueManager
  DatabaseHelper(); // Initialize the Database
  QueueManager(); // Initialize the QueueManager

  // * Save the list of currencies to SharedPreferences
  /* await CurrencyPreferences.removeCurrencies();
  await CurrencyPreferences.saveCurrencies(currencies); */

  //* Save the list of currencies to SharedPreferences
  /* await LanguagePreferences.removeLanguages();
  await LanguagePreferences.saveLanguages(languages); */

  // * Remove user data from SharedPreferences
  // await UserPreferences.clearAllUserData();

  //* Save the list of expense/income category to SharedPreferences
  /*await SharedPreferencesHandler.removeCategories();
  await SharedPreferencesHandler.saveExpenseCategories(majorExpenseCategories);
  await SharedPreferencesHandler.saveIncomeCategories(majorIncomeCategories);*/

  // Load the selected language from SharedPreferences
  CurrencyModel? selectedCurrency =
      await CurrencyPreferences.getSelectedCurrency();
  debugPrint(
      '---> Selected Currency :: main.dart :: ${selectedCurrency?.fullName}');
  LanguageModel? selectedLanguage =
      await LanguagePreferences.getSelectedLanguage();
  debugPrint('---> Selected Lang :: main.dart :: ${selectedLanguage?.name}');
  Locale initialLocale = selectedLanguage != null
      ? Locale(selectedLanguage.locale)
      : const Locale('en');

  runApp(MainApp(initialLocale: initialLocale));
}

/* Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message
} */

/* Future<void> migrateData({required String userId}) async {
  try {
    // Fetch data from PocketBase
    List<ExpenseModel> expenses = await ExpenseAPIService.fetchExpenses();
    print('---> Expenses len :: from PB :: ${expenses.length}');
    List<IncomeModel> incomes = await IncomeAPIService.fetchIncomeList();
    print('---> Income len :: from PB :: ${incomes.length}');
    List<BudgetModel> budgets = await BudgetAPIService.fetchbudgets();
    print('---> Budget len :: from PB :: ${budgets.length}');
    List<AccountsModel> accounts = await AccountAPIService.fetchAccounts();
    print('---> Account len :: from PB :: ${accounts.length}');
    List<TransfersModel> transfers = await TransferAPIService.fetchTransfers();
    print('---> Transfer len :: from PB :: ${transfers.length}');

    for (var expense in expenses) {
      expense.copyWith(userId: userId);
      await ExpenseHandler().insertExpense(expense: expense);
    }

    for (var income in incomes) {
      income.copyWith(userId: userId);
      await IncomeHandler().insertIncome(income: income);
    }

    for (var budget in budgets) {
      budget.copyWith(userId: userId);
      await BudgetHandler().insertBudget(budget: budget);
    }

    for (var account in accounts) {
      account.copyWith(userId: userId);
      await AccountHandler().insertAccount(account: account);
    }

    for (var transfer in transfers) {
      transfer.copyWith(userId: userId);
      await TransferHandler().insertTransfer(transfer: transfer);
    }

    print('Data migration completed successfully.');
  } catch (e) {
    print('Error during data migration: $e');
  }
} */

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
