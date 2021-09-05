import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    int? id,
    @Default('') String title,
    @JsonKey(name: 'is_done') @Default(0) int isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
