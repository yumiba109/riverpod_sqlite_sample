import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sqlite_sample/databases/todo_database.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';
import 'package:riverpod_sqlite_sample/repositories/todo_repository.dart';
import 'package:riverpod_sqlite_sample/states/todo_state.dart';

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModelProvider(
    ref.read,
    TodoRepository(TodoDatabase()),
  ),
);

class TodoViewModelProvider extends StateNotifier<TodoState> {
  TodoViewModelProvider(this._reader, this._todoRepository)
      : super(const TodoState()) {}

  final Reader _reader;
  final TodoRepository _todoRepository;

  Future<void> addTodo(String title) async {
    final todo = await _todoRepository.addTodo(Todo(
      title: title,
      isDone: 0,
    ));
  }
}
