import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/tasks/model/tasks_model.dart';

import 'widgets.dart';

class TasksListWidget extends StatelessWidget {
  TasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksCount =
        TasksModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: tasksCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1, thickness: 3);
      },
      itemBuilder: (BuildContext context, int index) {
        return TasksListRowWidget(indexInList: index);
      },
    );
  }
}
