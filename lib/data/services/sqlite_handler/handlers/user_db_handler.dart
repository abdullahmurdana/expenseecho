import 'package:expenseecho/data/models/user_model/user_model.dart';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/encryption_helper.dart';
import 'package:expenseecho/data/services/shared_preferences/user_preferences.dart';
import 'package:expenseecho/data/services/sqlite_handler/sqlite_database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserHandler {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<bool> insertUser({required UserModel user}) async {
    try {
      final db = await _databaseHelper.database;
      final DateTime now = DateTime.now();
      var userUpdated = user.copyWith(
        id: Config.generateRandomId(),
        password: EncryptionHelper.encryptPassword(user.password),
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
      );

      var insertedID = await db.insert(
        'users',
        userUpdated.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('---> Inserted UserID :: $insertedID');
      return true;
    } catch (e) {
      throw Exception("Failed to add user.");
    }
  }

  Future<UserModel?> getUserById({required String id}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final user = UserModel.fromMap(maps.first);
      return user.copyWith(
          password: EncryptionHelper.decryptPassword(user.password));
    } else {
      return null;
    }
  }

  Future<List<UserModel>?> getUsers() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return UserModel.fromMap(maps[i]);
      });
    } else {
      return null;
    }
  }

  Future<void> updateUser({required UserModel user}) async {
    final db = await _databaseHelper.database;
    user = user.copyWith(updatedAt: DateTime.now().toIso8601String());
    await db.update(
      'users',
      user
          .copyWith(password: EncryptionHelper.encryptPassword(user.password))
          .toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser({required String id}) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> resetPassword(
      {required String id, required String newPassword}) async {
    final db = await _databaseHelper.database;
    await db.update(
      'users',
      {'password': EncryptionHelper.encryptPassword(newPassword)},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<UserModel?> signIn(
      {required String email, required String password}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    print('---> Login :: Local DB :: Maps:${maps.toString()}');

    if (maps.isNotEmpty) {
      final user = UserModel.fromMap(maps.first);

      final decryptedPassword = EncryptionHelper.decryptPassword(user.password);
      if (decryptedPassword == password) {
        // Save user data to SharedPreferences
        await UserPreferences.saveUserData(user);
        await UserPreferences.setUserSignedIn(true);
        return user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> signUp({required UserModel user}) async {
    bool isInserted = await insertUser(user: user);
    if (isInserted) {
      // Save user data to SharedPreferences
      await UserPreferences.saveUserData(user);
      await UserPreferences.setUserSignedIn(true);
    }
    return isInserted;
  }

  Future<void> forgotPassword(
      {required String email, required String newPassword}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      final user = UserModel.fromMap(maps.first);
      await resetPassword(id: user.id ?? '', newPassword: newPassword);
    }
  }
}
