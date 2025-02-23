// app_data_provider.dart
import 'package:flutter/material.dart';

// Define the model for SelectedApp
class SelectedApp {
  final String name;
  final int targetHours;

  SelectedApp({required this.name, required this.targetHours});
}

// Create the AppData provider class
class AppData with ChangeNotifier {
  List<SelectedApp> _selectedApps = [];

  List<SelectedApp> get selectedApps => _selectedApps;

  void addApp(SelectedApp app) {
    _selectedApps.add(app);
    notifyListeners();
  }

  void clearApps() {
    _selectedApps.clear();
    notifyListeners();
  }
}
