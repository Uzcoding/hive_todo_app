import 'package:flutter/material.dart';

import 'model/group_form_model.dart';
import 'widgets/widgets.dart';

class GroupFormPage extends StatefulWidget {
  const GroupFormPage({Key? key}) : super(key: key);

  @override
  State<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends State<GroupFormPage> {
  final _model = GroupFormModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormModelProvider(
      model: _model,
      child: const GroupFormBodyWidget(),
    );
  }
}
