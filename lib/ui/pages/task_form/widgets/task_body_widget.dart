import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/task_form/model/task_form_model.dart';

import 'task_text_widget.dart';

class TaskFormBodyWidget extends StatelessWidget {
  const TaskFormBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormModelProvider.watch(context)?.model;
    final actionButton = FloatingActionButton(
      child: const Icon(Icons.done),
      onPressed: () => model?.saveTask(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const TaskTextWidget(),
      ),
      floatingActionButton: model?.isValid == true ? actionButton : null,
    );
  }
}
