import 'package:riverpod_sqlite_sample/databases/app_database.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase extends AppDatabase {
  final String _tableName = 'todos';

  Future insert(Todo todo) async {
    final db = await database;

    return await db.insert(
      _tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
