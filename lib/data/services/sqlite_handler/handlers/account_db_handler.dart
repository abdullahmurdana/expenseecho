import 'package:expenseecho/data/models/accounts/accounts_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class AccountHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertAccount({required AccountsModel account}) async {
    final db = await _databaseHelper.database;
    final DateTime now = DateTime.now();
    account = account.copyWith(
      id: Config.generateRandomId(),
      created: now.toIso8601String(),
      updated: now.toIso8601String(),
    );
    await db.insert('accounts', account.toMap());
  }

  Future<List<AccountsModel>> getAccounts() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('accounts');

    return List.generate(maps.length, (i) {
      return AccountsModel.fromMap(maps[i]);
    });
  }

  Future<AccountsModel?> getAccountById({required String accountId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'accounts',
      where: 'id = ?',
      whereArgs: [accountId],
    );

    if (maps.isNotEmpty) {
      return AccountsModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<AccountsModel>?> getAccountsByUserId(
      {required String userId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'accounts',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return AccountsModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<void> updateAccount({required AccountsModel account}) async {
    final db = await _databaseHelper.database;
    account = account.copyWith(updated: DateTime.now().toIso8601String());
    await db.update(
      'accounts',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<void> updateAccountBalance(
      {required String accountId, required double newBalance}) async {
    final db = await _databaseHelper.database;
    await db.update(
      'accounts',
      {
        'balance': newBalance,
        'updated': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [accountId],
    );
  }

  Future<void> deleteAccount(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> updateUserIdForAllData(String newUserId) async {
    try {
      final db = await _databaseHelper.database;

      // Update userId in expenses table
      await db.rawUpdate(
        'UPDATE expenses SET user_id = ?',
        [newUserId],
      );

      // Update userId in incomes table
      await db.rawUpdate(
        'UPDATE incomes SET user_id = ?',
        [newUserId],
      );

      // Update userId in budgets table
      await db.rawUpdate(
        'UPDATE budgets SET user_id = ?',
        [newUserId],
      );

      // Update userId in transfers table
      await db.rawUpdate(
        'UPDATE transfers SET user_id = ?',
        [newUserId],
      );

      // Update userId in accounts table
      await db.rawUpdate(
        'UPDATE accounts SET user_id = ?',
        [newUserId],
      );

      return true;
    } catch (e) {
      print('Failed to update userId for all data: $e');
      return false;
    }
  }
}
