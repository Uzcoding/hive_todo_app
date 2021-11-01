import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/task_form/model/task_form_model.dart';

class TaskTextWidget extends StatelessWidget {
  const TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = TaskFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task name',
      ),
      onEditingComplete: () => _model?.saveTask(context),
      onChanged: (value) => _model?.taskText = value,
    );
  }
}
