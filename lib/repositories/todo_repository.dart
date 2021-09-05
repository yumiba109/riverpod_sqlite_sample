import 'package:riverpod_sqlite_sample/databases/todo_database.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';

class TodoRepository {
  final _db = TodoDatabase();

  final TodoDatabase _todoDatabase;

  TodoRepository(this._todoDatabase);

  Future<List<Todo>> getTodos() async {
    return _todoDatabase.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    return _todoDatabase.insert(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    return _todoDatabase.update(todo);
  }
}
