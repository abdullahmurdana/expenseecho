import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class QueueHandler {
  static final DatabaseHelper _databaseHelper = DatabaseHelper();

  static Future<int> insertTransaction({
    required String type,
    required String data,
    String? id,
  }) async {
    final db = await _databaseHelper.database;
    return await db.insert('transactions', {
      'id': id ?? Config.generateRandomId(),
      'type': type,
      'data': data,
    });
  }

  static Future<List<Map<String, dynamic>>> getPendingTransactions() async {
    final db = await _databaseHelper.database;
    return await db.query('transactions');
  }

  static Future<int> deleteTransaction({required String id}) async {
    final db = await _databaseHelper.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
