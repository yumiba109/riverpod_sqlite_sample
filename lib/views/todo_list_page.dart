import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sqlite_sample/models/todo.dart';
import 'package:riverpod_sqlite_sample/viewModels/todo_view_model.dart';
import 'package:riverpod_sqlite_sample/views/todo_add_page.dart';

class TodoListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _todoList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) {
                return TodoAddPage();
              },
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }

  Widget _todoList() {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);
    final todoState = useProvider(todoViewModelProvider);

    return ListView.builder(
      itemCount: todoState.todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todoState.todos[index];

        return _todoItem(todo, index, todoViewModel);
      },
    );
  }

  Widget _todoItem(Todo todo, int index, TodoViewModelProvider todoViewModel) {
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: '削除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await todoViewModel.deleteTodo(todo.id!);
          },
        ),
      ],
      child: CheckboxListTile(
        title: Text(
          todo.title,
          style: TextStyle(
              decoration: todo.isDone == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        value: todo.isDone == 1 ? true : false,
        onChanged: (value) {
          todoViewModel.changeStatus(todo, value! ? 1 : 0);
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
