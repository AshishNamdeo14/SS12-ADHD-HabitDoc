import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:ss12/models/selectedapps.dart';

class AppUsageScreen extends StatefulWidget {
  final List<SelectedApp> selectedApps;

  AppUsageScreen({required this.selectedApps});

  @override
  _AppUsageScreenState createState() => _AppUsageScreenState();
}

class _AppUsageScreenState extends State<AppUsageScreen> {
  List<AppUsageInfo> _appUsageInfos = [];

  @override
  void initState() {
    super.initState();
    _getUsageStats();
  }

  void _getUsageStats() async {
    try {
      DateTime now = DateTime.now();
      DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
      DateTime endDate = now;

      List<AppUsageInfo> usageInfoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      setState(() => _appUsageInfos = usageInfoList);
    } catch (e) {
      print("Error fetching app usage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Usage Comparison"),
        backgroundColor: Colors.green,
      ),
      body:
          _appUsageInfos.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: widget.selectedApps.length,
                itemBuilder: (context, index) {
                  String appName = widget.selectedApps[index].name;
                  int targetHours = widget.selectedApps[index].targetHours;

                  // Find actual usage, default to 0 hours if not found
                  double actualHours = 0.0;
                  for (var usage in _appUsageInfos) {
                    if (usage.packageName.toLowerCase().contains(
                      appName.toLowerCase(),
                    )) {
                      actualHours =
                          usage.usage.inMinutes /
                          60.0; // Convert minutes to hours
                      break;
                    }
                  }
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListTile(
                      title: Text(
                        appName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Target: ${targetHours} hrs | Used: ${actualHours.toStringAsFixed(2)} hrs",
                        style: TextStyle(
                          color:
                              actualHours > targetHours
                                  ? Colors.red
                                  : Color(0xFF76B4B5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
