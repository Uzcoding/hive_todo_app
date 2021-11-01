import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_todo_app/ui/pages/groups/model/groups_model.dart';

class GroupsListRowWidget extends StatelessWidget {
  final int indexInList;
  const GroupsListRowWidget({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = GroupsModelProvider.read(context)!.model;
    final group = _model.groups[indexInList];
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _model.deleteGroup(indexInList),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _model.showTasks(context, indexInList),
        ),
      ),
    );
  }
}
