import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/group_form/model/group_form_model.dart';

import 'group_name_widget.dart';

class GroupFormBodyWidget extends StatelessWidget {
  const GroupFormBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const GroupNameWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () =>
            GroupFormModelProvider.read(context)?.model.saveGroup(context),
      ),
    );
  }
}
