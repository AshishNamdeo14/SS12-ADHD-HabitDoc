import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class DailyTaskPage extends StatefulWidget {
  @override
  _DailyTaskPageState createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  List<Map<String, dynamic>> tasks = [];
  int points = 0;
  String currentDate = "";
  late ConfettiController _confettiController;

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
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
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
        if (task["id"] == taskId && !task["completed"]) {
          task["completed"] = true;
          points += task["reward"] as int;
          _confettiController.play(); // Play confetti animation
        }
      }
    });
    await prefs.setString("tasks", jsonEncode(tasks));
    await prefs.setInt("points", points);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int completedTasks = tasks.where((task) => task["completed"] == true).length;
    double progress = (completedTasks / tasks.length);

    return Scaffold(
      backgroundColor: Color(0xFF76B4B5),
      appBar: AppBar(title: Text("🎯 Daily Task Rewards"), backgroundColor: Color(0xFF76B4B5)),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tasks for $currentDate", style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 10),
                LinearProgressIndicator(value: progress),
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
                                  .animate()
                                  .scale(duration: 300.ms, curve: Curves.easeOut)
                              : ElevatedButton(
                                  onPressed: () => _completeTask(task["id"]),
                                  child: Text("Complete"),
                                ),
                        ),
                      ).animate().fade(duration: 500.ms);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("🎁 Points: $points", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Confetti Animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // 90 degrees (upwards)
              emissionFrequency: 0.05,
              numberOfParticles: 10,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
