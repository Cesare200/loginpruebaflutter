import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../helpers/database_helper.dart';

class UserDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(User user) async {
    Database db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getAllUsers() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> data = await db.query('users');
    return data.map((e) => User.fromMap(e)).toList();
  }

  Future<int> updateUser(User user) async {
    Database db = await dbHelper.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await dbHelper.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
