import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/groups/model/groups_model.dart';

import 'groups_list_row_widget.dart';

class GroupsListWidget extends StatelessWidget {
  GroupsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1, thickness: 3);
      },
      itemBuilder: (BuildContext context, int index) {
        return GroupsListRowWidget(indexInList: index);
      },
    );
  }
}
