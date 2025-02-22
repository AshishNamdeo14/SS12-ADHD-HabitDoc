import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ss12/components/base/MainBody.dart';
import 'package:ss12/components/base/footer/homeFooter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 142, 183, 253),
      appBar: AppBar(
       backgroundColor: const Color.fromARGB(255, 142, 183, 253),
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
          Text(
            "Rewards: 100",
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Text(
            "Level: 5",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  // ignore: deprecated_member_use
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
      body: MainBody(),
      bottomNavigationBar: homeFooter(),
    );
  }
}

