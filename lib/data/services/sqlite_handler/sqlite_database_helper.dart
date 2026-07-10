import 'package:expenseecho/data/services/sqlite_handler/queries/account_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/budget_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/expense_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/income_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/transaction_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/transfer_queries.dart';
import 'package:expenseecho/data/services/sqlite_handler/queries/user_queries.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
      print("---> Database initialized successfully");
    } catch (e) {
      print("---> Error initializing database: $e");
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    try {
      return await openDatabase(
        path,
        version: 3, // Incremented version number
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print("---> Error opening database: $e");
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      // add expense table
      await db.execute(createExpenseTable);
      print("---> Expense table created successfully");

      // add income table
      await db.execute(createIncomeTable);
      print("---> Income table created successfully");

      // add transfer table
      await db.execute(createTransferTable);
      print("---> Transfer table created successfully");

      // add accounts table
      await db.execute(createAccountTable);
      print("---> Accounts table created successfully");

      // add budgets table
      await db.execute(createBudgetTable);
      print("---> Budgets table created successfully");

      // add users table
      await db.execute(createUserTable);
      print("---> Users table created successfully");

      // add transaction table
      await db.execute(createTransactionTable);
      print("---> Transaction table created successfully");
    } catch (e) {
      print("---> Error creating tables: $e");
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      if (oldVersion < 3) {
        // Drop the old transactions table
        await db.execute('DROP TABLE IF EXISTS transactions');
        print("---> Old transactions table dropped successfully");

        // Create the new transactions table
        await db.execute(createTransactionTable);
        print("---> New transactions table created successfully");
      }
    } catch (e) {
      print("---> Error upgrading database: $e");
      rethrow;
    }
  }
}
