import 'package:flutter/material.dart';
import 'package:hive_todo_app/ui/pages/pages.dart';

abstract class MainNavigationRoutNames {
  static const groups = '/';
  static const groupsForm = '/group/form';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRoutNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutNames.groups: (context) => const GroupsPage(),
    MainNavigationRoutNames.groupsForm: (context) => const GroupFormPage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutNames.tasks:
        final configuration = settings.arguments as TasksConfiguration;
        return MaterialPageRoute(
          builder: (context) => TasksPage(configuration: configuration),
        );
      case MainNavigationRoutNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TaskFormPage(groupKey: groupKey),
        );

      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
