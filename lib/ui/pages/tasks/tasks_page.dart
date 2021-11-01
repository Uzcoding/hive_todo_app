import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/tasks/model/tasks_model.dart';

import 'widgets/widgets.dart';

class TasksConfiguration {
  final int groupKey;
  final String title;

  TasksConfiguration({required this.groupKey, required this.title});
}

class TasksPage extends StatefulWidget {
  final TasksConfiguration configuration;
  const TasksPage({
    Key? key,
    required this.configuration,
  }) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TasksModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return TasksModelProvider(
      model: _model,
      child: const TasksBodyWidget(),
    );
  }

  // @override
  // void dispose() async {
  //   await _model.dispose();
  //   super.dispose();
  // }
}
