import 'package:flutter/material.dart';

class RewardDetailPage extends StatelessWidget {
  final String reward;
  RewardDetailPage({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reward Details")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text(reward, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}