import 'package:flutter/material.dart';
import 'package:hive_todo_app/domain/data_provider/box_manager.dart';
import 'package:hive_todo_app/domain/entity/group.dart';

class GroupFormModel extends ChangeNotifier {
  String _groupName = '';
  String? errorText;

  set groupName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  void saveGroup(BuildContext context) async {
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText = 'Enter group name';
      notifyListeners();
      return;
    }

    final _box = await BoxManager.instance.openGroupBox();
    await _box.add(Group(name: groupName));
    await BoxManager.instance.closeBox(_box);
    Navigator.of(context).pop();
  }
}

class GroupFormModelProvider extends InheritedNotifier {
  final GroupFormModel model;

  GroupFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static GroupFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupFormModelProvider>();
  }

  static GroupFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormModelProvider>()
        ?.widget;
    return widget is GroupFormModelProvider ? widget : null;
  }
}
