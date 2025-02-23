import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ss12/components/vr_characters/CameraPage.dart';

class CharacterDetail extends StatelessWidget {
  final String name;
  final IconData icon;

  const CharacterDetail({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCamPage(),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(icon, size: 100, color: Colors.deepPurple),
      //       const SizedBox(height: 20),
      //       Text(
      //         name,
      //         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
