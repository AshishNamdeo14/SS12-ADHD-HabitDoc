import 'package:flutter/material.dart';
import 'package:ss12/components/base/_home/AppUsageScreen.dart';
import 'package:ss12/components/base/_home/HomePage.dart';
import 'package:ss12/models/selectedapps.dart';


class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  final List<Map<String, dynamic>> socialMediaApps = [
    {'name': 'Instagram', 'selected': false, 'hours': TextEditingController()},
    {'name': 'Facebook', 'selected': false, 'hours': TextEditingController()},
    {'name': 'Twitter', 'selected': false, 'hours': TextEditingController()},
    {'name': 'YouTube', 'selected': false, 'hours': TextEditingController()},
    {'name': 'Snapchat', 'selected': false, 'hours': TextEditingController()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF76B4B5),
      appBar: AppBar(
        title: Text('Select Social Media & Hours'),
        backgroundColor: Color(0xFF76B4B5),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select the apps you use and set time limits:",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Column(
                children:
                    socialMediaApps.map((app) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: app['selected'],
                              onChanged: (bool? value) {
                                setState(() {
                                  app['selected'] = value!;
                                });
                              },
                            ),
                            Text(
                              app['name'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 80,
                              child: TextField(
                                controller: app['hours'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Hrs",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                enabled: app['selected'],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C4753),
                  ),
                  onPressed: () {
                    _navigateToUsageScreen();
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUsageScreen() {
    List<SelectedApp> selectedApps = [];

    for (var app in socialMediaApps) {
      if (app['selected'] && app['hours'].text.isNotEmpty) {
        selectedApps.add(
          SelectedApp(
            name: app['name'], // ✅ Use named parameters
            targetHours:
                int.tryParse(app['hours'].text) ?? 0, // ✅ Prevent crashes
          ),
        );
      }
    }

    if (selectedApps.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            selectedApps: selectedApps,
          ),
        ),
      );
    } else {
      _showNoAppsSelectedDialog();
    }
  }

  void _showNoAppsSelectedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("No Apps Selected"),
            content: Text("Please select at least one app and enter hours."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }
}