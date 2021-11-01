import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/groups/model/groups_model.dart';

import 'groups_list_widget.dart';

class GroupsBodyWidget extends StatelessWidget {
  const GroupsBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: GroupsListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            GroupsModelProvider.read(context)?.model.showForm(context),
      ),
    );
  }
}
