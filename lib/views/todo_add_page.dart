import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sqlite_sample/viewModels/todo_view_model.dart';

class TodoAddPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final todoViewModel = useProvider(todoViewModelProvider.notifier);

    final _titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
          ),
          ElevatedButton(
            onPressed: () async {
              await todoViewModel.addTodo(_titleController.text);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
