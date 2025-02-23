import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DailyTaskPage extends StatefulWidget {
  @override
  _DailyTaskPageState createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  List<Map<String, dynamic>> tasks = [];
  int points = 0;
  String currentDate = "";

  final List<Map<String, dynamic>> taskData = [
    {"id": 1, "text": "Complete a coding challenge", "reward": 10},
    {"id": 2, "text": "Read a technical article", "reward": 5},
    {"id": 3, "text": "Contribute to open source", "reward": 15},
    {"id": 4, "text": "Practice DSA problems", "reward": 10},
    {"id": 5, "text": "Workout for 30 minutes", "reward": 8},
  ];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().split("T")[0];
    String? storedDate = prefs.getString("taskDate");
    
    if (storedDate != today) {
      tasks = taskData.map((task) => {...task, "completed": false}).toList();
      points = 0;
      await prefs.setString("taskDate", today);
      await prefs.setString("tasks", jsonEncode(tasks));
      await prefs.setInt("points", points);
    } else {
      String? storedTasks = prefs.getString("tasks");
      points = prefs.getInt("points") ?? 0;
      tasks = storedTasks != null ? List<Map<String, dynamic>>.from(jsonDecode(storedTasks)) : taskData;
    }
    setState(() {
      currentDate = today;
    });
  }

  Future<void> _completeTask(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var task in tasks) {
        if (task["id"] == taskId) {
          task["completed"] = true;
          points += task["reward"] as int;
        }
      }
    });
    await prefs.setString("tasks", jsonEncode(tasks));
    await prefs.setInt("points", points);
  }

  @override
  Widget build(BuildContext context) {
    int completedTasks = tasks.where((task) => task["completed"] == true).length;
    double progress = (completedTasks / tasks.length) * 100;

    return Scaffold(
      appBar: AppBar(title: Text("🎯 Daily Task Rewards")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tasks for $currentDate", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            LinearProgressIndicator(value: progress / 100),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        task["text"],
                        style: TextStyle(
                          decoration: task["completed"] ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: task["completed"]
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : ElevatedButton(
                              onPressed: () => _completeTask(task["id"]),
                              child: Text("Complete"),
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text("🎁 Points: $points", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
