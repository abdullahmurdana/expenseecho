import 'package:expenseecho/data/models/expense/expense_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class ExpenseHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertExpense({required ExpenseModel expense}) async {
    final db = await _databaseHelper.database;
    final DateTime now = DateTime.now();
    expense = expense.copyWith(
      id: expense.id ?? Config.generateRandomId(),
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    await db.insert('expenses', expense.toMap());
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    return List.generate(maps.length, (i) {
      return ExpenseModel.fromMap(maps[i]);
    });
  }

  // New method for getting expense info by expense ID
  Future<ExpenseModel?> getExpenseById({required String expenseId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [expenseId],
    );

    if (maps.isNotEmpty) {
      return ExpenseModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // New method for getting expenses list by user ID
  Future<List<ExpenseModel>?> getExpensesByUserId(
      {required String userId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return ExpenseModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<void> updateExpense(
      {required String expenseId, required ExpenseModel expense}) async {
    final db = await _databaseHelper.database;
    expense = expense.copyWith(updatedAt: DateTime.now().toIso8601String());
    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expenseId],
    );
  }

  Future<void> deleteExpense({required String expenseId}) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [expenseId],
    );
  }

  // New method to delete all expenses
  Future<void> deleteAllExpenses() async {
    final db = await _databaseHelper.database;
    await db.execute('DELETE FROM expenses');
  }
}
