import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/domain/data_provider/box_manager.dart';
import 'package:hive_todo_app/domain/entity/task.dart';
import 'package:hive_todo_app/ui/navigation/main_navigation.dart';
import 'package:hive_todo_app/ui/pages/tasks/tasks_page.dart';

class TasksModel extends ChangeNotifier {
  TasksConfiguration configuration;
  late final Future<Box<Task>> _box;
  late ValueListenable<Object>? _listenableBox;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  TasksModel({required this.configuration}) {
    _setup();
  }

  void _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);

    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTasksFromHive);
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  void doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRoutNames.tasksForm,
        arguments: configuration.groupKey);
  }

  @override
  Future<void> dispose() async {
    _listenableBox?.removeListener(_readTasksFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}

class TasksModelProvider extends InheritedNotifier {
  final TasksModel model;

  TasksModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TasksModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksModelProvider>();
  }

  static TasksModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksModelProvider>()
        ?.widget;
    return widget is TasksModelProvider ? widget : null;
  }
}
