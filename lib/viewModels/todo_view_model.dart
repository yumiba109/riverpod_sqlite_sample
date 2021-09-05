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
      : super(const TodoState()) {
    getTodos();
  }

  final Reader _reader;
  final TodoRepository _todoRepository;

  Future<void> addTodo(String title) async {
    final todo = await _todoRepository.addTodo(Todo(
      title: title,
      isDone: 0,
    ));
  }

  Future<void> getTodos() async {
    final todos = await _todoRepository.getTodos();

    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> changeStatus(Todo todo, int value) async {
    final newTodo = todo.copyWith(
      isDone: value,
    );

    await _todoRepository.updateTodo(newTodo);

    final todos = state.todos
        .map((todo) => todo.id == newTodo.id ? newTodo : todo)
        .toList();

    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> deleteTodo(int todoId) async {
    await _todoRepository.deleteTodo(todoId);

    final todos = state.todos.where((todo) => todo.id != todoId).toList();

    state = state.copyWith(
      todos: todos,
    );
  }
}
