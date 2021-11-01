import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/task_form/model/task_form_model.dart';

import 'widgets/widgets.dart';

class TaskFormPage extends StatefulWidget {
  final int groupKey;
  const TaskFormPage({
    Key? key,
    required this.groupKey,
  }) : super(key: key);

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  late final TaskFormModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormModelProvider(
      model: _model,
      child: const TaskFormBodyWidget(),
    );
  }
}
