import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/domain/data_provider/box_manager.dart';
import 'package:hive_todo_app/domain/entity/group.dart';
import 'package:hive_todo_app/ui/navigation/main_navigation.dart';
import 'package:hive_todo_app/ui/pages/tasks/tasks_page.dart';
import 'package:pedantic/pedantic.dart';

class GroupsModel extends ChangeNotifier {
  var _groups = <Group>[];
  late final Future<Box<Group>> _box;
  late ValueListenable<Object>? _listenableBox;

  List<Group> get groups => _groups.toList();

  GroupsModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRoutNames.groupsForm);
  }

  void showTasks(BuildContext context, int groupIndex) async {
    final group = (await _box).getAt(groupIndex);
    if (group != null) {
      final configuration =
          TasksConfiguration(groupKey: group.key as int, title: group.name);

      unawaited(Navigator.of(context).pushNamed(
        MainNavigationRoutNames.tasks,
        arguments: configuration,
      ));
    }
  }

  Future<void> _readGroupsFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  void _setup() async {
    _box = BoxManager.instance.openGroupBox();

    await _readGroupsFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readGroupsFromHive);
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await _box;
    final groupKey = (await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);

    await Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(groupIndex);
  }

  @override
  Future<void> dispose() async {
    _listenableBox?.removeListener(_readGroupsFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}

class GroupsModelProvider extends InheritedNotifier {
  final GroupsModel model;

  GroupsModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static GroupsModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupsModelProvider>();
  }

  static GroupsModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsModelProvider>()
        ?.widget;
    return widget is GroupsModelProvider ? widget : null;
  }
}
