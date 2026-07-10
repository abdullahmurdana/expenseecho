import 'package:expenseecho/data/models/transfers/transfers_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';

class TransferHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertTransfer({required TransfersModel transfer}) async {
    final db = await _databaseHelper.database;
    final DateTime now = DateTime.now();

    transfer = transfer.copyWith(
      id: Config.generateRandomId(),
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    await db.insert('transfers', transfer.toMap());
  }

  Future<List<TransfersModel>> getTransfers() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('transfers');

    return List.generate(maps.length, (i) {
      return TransfersModel.fromMap(maps[i]);
    });
  }

  // New method for getting budget info by budget ID
  Future<TransfersModel?> getTransferById({required String transferId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transfers',
      where: 'id = ?',
      whereArgs: [transferId],
    );

    if (maps.isNotEmpty) {
      return TransfersModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TransfersModel>?> getTransfersByUserId(
      {required String userId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transfers',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return TransfersModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<void> updateTransfer(
      {required String transferId, required TransfersModel transfer}) async {
    final db = await _databaseHelper.database;
    transfer = transfer.copyWith(updatedAt: DateTime.now().toIso8601String());
    await db.update(
      'transfers',
      transfer.toMap(),
      where: 'id = ?',
      whereArgs: [transferId],
    );
  }

  Future<void> deleteTransfer({required String id}) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'transfers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
