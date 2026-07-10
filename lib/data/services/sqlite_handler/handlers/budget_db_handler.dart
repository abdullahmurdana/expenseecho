import 'package:expenseecho/data/models/budget/budget_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class BudgetHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertBudget({required BudgetModel budget}) async {
    final db = await _databaseHelper.database;
    final DateTime now = DateTime.now();
    budget = budget.copyWith(
      id: Config.generateRandomId(),
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    await db.insert('budgets', budget.toMap());
  }

  Future<List<BudgetModel>> getBudgets() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('budgets');

    return List.generate(maps.length, (i) {
      return BudgetModel.fromMap(maps[i]);
    });
  }

  // New method for getting budget info by budget ID
  Future<BudgetModel?> getBudgetById({required String budgetId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'budgets',
      where: 'id = ?',
      whereArgs: [budgetId],
    );

    if (maps.isNotEmpty) {
      return BudgetModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // New method for getting budget info by budget ID
  Future<List<BudgetModel>?> getBudgetsByUserId(
      {required String userId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'budgets',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return BudgetModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<bool> updateBudget(
      {required String budgetId, required BudgetModel budget}) async {
    try {
      final db = await _databaseHelper.database;
      budget = budget.copyWith(updatedAt: DateTime.now().toIso8601String());
      await db.update(
        'budgets',
        budget.toMap(),
        where: 'id = ?',
        whereArgs: [budgetId],
      );
      return true;
    } catch (e) {
      throw Exception('Failed to update local budget');
    }
  }

  Future<void> deleteBudget(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
