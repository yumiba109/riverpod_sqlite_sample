import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final todoState = useProvider(todoViewModelProvider);

    return Container();
  }
}
