import 'package:expenseecho/data/models/income/income_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class IncomeHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertIncome({required IncomeModel income}) async {
    final db = await _databaseHelper.database;
    final DateTime now = DateTime.now();
    income = income.copyWith(
      id: Config.generateRandomId(),
      created: now.toIso8601String(),
      updated: now.toIso8601String(),
    );
    await db.insert('incomes', income.toMap());
  }

  Future<List<IncomeModel>> getIncomes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('incomes');

    return List.generate(maps.length, (i) {
      return IncomeModel.fromMap(maps[i]);
    });
  }

  // New method for getting budget info by budget ID
  Future<IncomeModel?> getIncomeById({required String incomeId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incomes',
      where: 'id = ?',
      whereArgs: [incomeId],
    );

    if (maps.isNotEmpty) {
      return IncomeModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // New method for getting expenses list by user ID
  Future<List<IncomeModel>?> getIncomesByUserId(
      {required String userId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incomes',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return IncomeModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<void> updateIncome(
      {required String incomeId, required IncomeModel income}) async {
    final db = await _databaseHelper.database;
    income = income.copyWith(updated: DateTime.now().toIso8601String());
    await db.update(
      'incomes',
      income.toMap(),
      where: 'id = ?',
      whereArgs: [incomeId],
    );
  }

  Future<void> deleteIncome({required String id}) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'incomes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // New method to delete all expenses
  Future<void> deleteAllIncomes() async {
    final db = await _databaseHelper.database;
    await db.execute('DELETE FROM incomes');
  }
}
