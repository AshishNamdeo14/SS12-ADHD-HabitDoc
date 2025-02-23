import 'package:flutter/material.dart';
import 'package:ss12/components/chat_screen/chat_screen.dart';
import 'package:ss12/components/vr_characters/vr_Character.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const homeFooter());

class homeFooter extends StatelessWidget {
  const homeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add_task)),
            label: 'Add Tasks',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.dashboard)),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Doctor Dope',
          ),
        ],
      ),
      body:
          <Widget>[
            VrCharacter(),
            ChatScreen(),
            /// Notifications page
            ChatScreen(),
            /// Messages page
            ChatScreen(),
            ChatScreen(),
          ][currentPageIndex],
    );
  }
}
