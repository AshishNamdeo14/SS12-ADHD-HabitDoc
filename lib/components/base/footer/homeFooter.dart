import 'package:flutter/material.dart';

// ignore: camel_case_types
class homeFooter extends StatelessWidget {
  const homeFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.blueAccent,
      destinations: const <Widget>[
          NavigationDestination(
          icon: Badge(child: Icon(Icons.dashboard)),
          label: 'Dashboard',
        ),
          NavigationDestination(
          icon: Badge(child: Icon(Icons.add_task)),
          label: 'Add Task',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.timer)),
          label: 'Timer',
        ),
        NavigationDestination(
          icon: Badge(label: Text('2'), child: Icon(Icons.message)),
          label: 'Messages',
        ),
      ],
    );
  }
}
