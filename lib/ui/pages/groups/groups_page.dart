import 'package:flutter/material.dart';

import 'model/groups_model.dart';
import 'widgets/widgets.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final _model = GroupsModel();
  @override
  Widget build(BuildContext context) {
    return GroupsModelProvider(
      model: _model,
      child: const GroupsBodyWidget(),
    );
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}
