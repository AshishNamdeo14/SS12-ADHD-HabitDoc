import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class Task {
  String name;
  int estimatedMinutes;

  Task({required this.name, required this.estimatedMinutes});
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  List<Task> tasks = [];
  final TextEditingController timeController = TextEditingController();
  String taskName = '';
  int minutes = 30;
  bool isMinutes = true;
  int _secondsRemaining = 0;
  bool isRunning = false;
  Timer? _timer;

  void _addTask(String name, int minutes) {
    setState(() {
      tasks.add(Task(name: name, estimatedMinutes: minutes));
    });
  }

  void _editTask(int index) {
    taskName = tasks[index].name;
    minutes = tasks[index].estimatedMinutes;
    timeController.text = minutes.toString();

    _showTaskDialog(
      title: 'Edit Task',
      initialName: taskName,
      initialMinutes: minutes,
      onConfirm: (name, minutes) {
        setState(() {
          tasks[index] = Task(name: name, estimatedMinutes: minutes);
        });
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _showAddTaskDialog() {
    _showTaskDialog(
      title: 'Add Task',
      onConfirm: (name, minutes) {
        _addTask(name, minutes);
      },
    );
  }

  void _startTimer(int duration) {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _secondsRemaining = duration * 60;
      isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _secondsRemaining = 0;
      isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  void _showTaskDialog({
    required String title,
    String initialName = '',
    int initialMinutes = 30,
    required Function(String, int) onConfirm,
  }) {
    String tempName = initialName;
    int tempMinutes = initialMinutes;
    timeController.text = tempMinutes.toString();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Color(0xFFF2F3F9),
            title: Text(title, style: TextStyle(color: Color(0xFF1C4C59))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Task Name'),
                  controller: TextEditingController(text: tempName),
                  onChanged: (value) => tempName = value,
                ),
                Row(
                  children: [
                    Text('Estimated Time: ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Enter time'),
                        onChanged: (value) {
                          int enteredTime = int.tryParse(value) ?? 0;
                          if (isMinutes) {
                            if (enteredTime < 30) {
                              timeController.text = '30';
                              tempMinutes = 30;
                            } else if (enteredTime > 600) {
                              timeController.text = '600';
                              tempMinutes = 600;
                            } else {
                              tempMinutes = enteredTime;
                            }
                          } else {
                            if (enteredTime < 1) {
                              timeController.text = '1';
                              tempMinutes = 60;
                            } else if (enteredTime > 10) {
                              timeController.text = '10';
                              tempMinutes = 600;
                            } else {
                              tempMinutes = enteredTime * 60;
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Min: 30 minutes, Max: 10 hours (600 minutes)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  children: [
                    Text('Time Unit: ', style: TextStyle(fontSize: 16)),
                    DropdownButton<bool>(
                      value: isMinutes,
                      onChanged: (value) {
                        setState(() {
                          isMinutes = value!;
                          timeController.text =
                              (isMinutes ? tempMinutes : tempMinutes ~/ 60)
                                  .toString();
                        });
                      },
                      items: [
                        DropdownMenuItem(value: true, child: Text('Minutes')),
                        DropdownMenuItem(value: false, child: Text('Hours')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF367BC1)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (tempName.isNotEmpty) {
                    onConfirm(tempName, tempMinutes);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1C4C59),
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Work for ${task.estimatedMinutes} minutes.\n'
                      'Break: ${(task.estimatedMinutes == 30) ? 1 : (task.estimatedMinutes / 30).floor()} '
                      'for 5 mins after every 25 mins of work.',
                    ),
                    trailing: SizedBox(
                      width: 100, // Constraining the width to avoid overflow
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editTask(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Start Pomodoro Button & Timer Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Pomodoro started!");
                          _startTimer(25);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1C4C59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Start Pomodoro',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Text(
                        _formatTime(_secondsRemaining),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Pause & Reset Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: isRunning ? _pauseTimer : null,
                        child: Text('Pause'),
                      ),
                      ElevatedButton(
                        onPressed: _resetTimer,
                        child: Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
      // bottomNavigationBar: HomeFooter(),
    );
  }
}
