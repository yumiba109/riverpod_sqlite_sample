import 'package:riverpod_sqlite_sample/databases/app_database.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase extends AppDatabase {
  final String _tableName = 'todos';

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    if (maps.isEmpty) return [];

    return maps.map((map) => Todo.fromJson(map)).toList();
  }

  Future insert(Todo todo) async {
    final db = await database;

    return await db.insert(
      _tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future update(Todo todo) async {
    final db = await database;

    return await db.update(
      _tableName,
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future delete(int id) async {
    final db = await database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
