import 'package:flutter/material.dart';
import 'package:ss12/components/Pomodoro/pomodorotimer.dart';
import 'package:ss12/components/base/_home/HomePage.dart';
import 'package:ss12/components/chat_screen/chat_screen.dart';
import 'package:ss12/components/dailyTasks/DailyTaskPage.dart';
import 'package:ss12/components/dashboard/DashboardPage.dart';
import 'package:ss12/models/selectedapps.dart';

class homeFooter extends StatefulWidget {
   final List<SelectedApp> selectedApps;
  const homeFooter({super.key, required this.selectedApps});

  @override
  _homeFooterState createState() => _homeFooterState();
}

class _homeFooterState extends State<homeFooter> {
  int _selectedIndex = 2; // Tracks the selected tab

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on selected index or destination
    switch (index) {
      case 0:
         Navigator.push(context, MaterialPageRoute(builder: (context) => ChartPage()));
        break;
      case 1:
       Navigator.push(context, MaterialPageRoute(builder: (context) => DailyTaskPage()));
        break;
      case 2:
        print(
          "Navigating to Home Page screen",
        ); // Print message before navigation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              print(
                "Home Page screen is being built",
              ); // Print when screen is built
              return HomePage(selectedApps: widget.selectedApps);
            },
          ),
        );

        break;
      case 3:
        print(
          "Navigating to PomodoroTimer screen",
        ); // Print message before navigation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              print(
                "PomodoroTimer screen is being built",
              ); // Print when screen is built
              return PomodoroTimer();
            },
          ),
        );

        break;
      case 4:
         Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex, // Set the selected tab
      onDestinationSelected: _onDestinationSelected, // Handle navigation
      indicatorColor: Colors.blueAccent,
      destinations: const <NavigationDestination>[
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.add_task), label: 'Daily Tasks'),
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(icon: Icon(Icons.timer), label: 'Timer'),
        NavigationDestination(icon: Icon(Icons.message), label: 'Dr Dope'),
      ],
    );
  }
}