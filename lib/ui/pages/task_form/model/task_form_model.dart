import 'package:flutter/material.dart';
import 'package:hive_todo_app/domain/data_provider/box_manager.dart';

import 'package:hive_todo_app/domain/entity/task.dart';

class TaskFormModel extends ChangeNotifier {
  int groupKey;
  String _taskText = '';
  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value) {
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  TaskFormModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;

    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);

    await box.add(task);
    await BoxManager.instance.closeBox(box);

    Navigator.of(context).pop();
  }
}

class TaskFormModelProvider extends InheritedNotifier {
  final TaskFormModel model;

  TaskFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TaskFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormModelProvider>();
  }

  static TaskFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormModelProvider>()
        ?.widget;
    return widget is TaskFormModelProvider ? widget : null;
  }
}
