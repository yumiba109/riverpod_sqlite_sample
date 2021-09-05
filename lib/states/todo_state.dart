import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> todos,
  }) = _TodoState;
}
