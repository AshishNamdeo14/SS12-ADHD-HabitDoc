import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:ss12/components/base/footer/homeFooter.dart';
import 'package:ss12/components/rewards_screen/RewardPage.dart';
import 'package:ss12/models/selectedapps.dart';

class HomePage extends StatefulWidget {
  final List<SelectedApp> selectedApps;
  const HomePage({super.key, required this.selectedApps});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<AppUsageInfo> _appUsageInfos = [];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevents back navigation
      child: Scaffold(
        backgroundColor:  Color(0xFF76B4B5),
        appBar: AppBar(
          automaticallyImplyLeading: false, // Hides the back button
          backgroundColor:  Color(0xFF76B4B5),
          title: Column(
            children: [
              Text(
                "HabbitDoc",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RewardPage()),
                      );
                    },
                    child: Text(
                      "Rewards: 100",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.yellowAccent,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            offset: Offset(2.0, 2.0),
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Streaks: 5",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellowAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: widget.selectedApps.isEmpty
                  ? Center(
                      child: Text(
                        "No apps selected.",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.selectedApps.length,
                      itemBuilder: (context, index) {
                        String appName = widget.selectedApps[index].name;
                        final app = widget.selectedApps[index];
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
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                            title: Text(
                              app.name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            
                            subtitle: Text("Target Hours: ${app.targetHours} | Used: ${actualHours.toStringAsFixed(2)} hrs"),
                            leading: Icon(Icons.apps, color: Colors.blue),
                          ),
                        );
                      },
                    ),
            ),
            homeFooter(selectedApps: widget.selectedApps),
          ],
        ),
      ),
    );
  }
}
