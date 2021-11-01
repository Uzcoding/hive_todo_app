import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/group_form/model/group_form_model.dart';

class GroupNameWidget extends StatelessWidget {
  const GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = GroupFormModelProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Group name',
        errorText: _model?.errorText,
      ),
      onEditingComplete: () => _model?.saveGroup(context),
      onChanged: (value) => _model?.groupName = value,
    );
  }
}
