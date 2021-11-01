import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_todo_app/ui/pages/tasks/model/tasks_model.dart';

class TasksListRowWidget extends StatelessWidget {
  final int indexInList;
  const TasksListRowWidget({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = TasksModelProvider.read(context)!.model;
    final task = _model.tasks[indexInList];

    final icon = task.isDone ? Icons.done : Icons.circle_outlined;
    final style =
        task.isDone ? TextDecoration.lineThrough : TextDecoration.none;

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _model.deleteTask(indexInList),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text,
            style: TextStyle(decoration: style),
          ),
          trailing: Icon(icon),
          onTap: () => _model.doneToggle(indexInList),
        ),
      ),
    );
  }
}
