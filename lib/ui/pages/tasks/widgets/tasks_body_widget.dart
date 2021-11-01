import 'package:flutter/material.dart';

import 'package:hive_todo_app/ui/pages/tasks/model/tasks_model.dart';

import 'tasks_list_widget.dart';

class TasksBodyWidget extends StatelessWidget {
  const TasksBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? 'Tasks';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => model?.showForm(context),
      ),
    );
  }
}
