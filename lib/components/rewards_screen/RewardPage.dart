import 'package:flutter/material.dart';
import 'package:ss12/components/rewards_screen/ArRewards.dart' as ar;
import 'package:ss12/components/rewards_screen/RewardsDetailPage.dart' as rd;
import 'package:ss12/components/vr_characters/vr_Character.dart';

class RewardPage extends StatelessWidget {
  final List<String> rewards = ["Gold Coin", "Mystery Box", "Diamond", "Magic Potion", "XP Boost","AR Characters"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Rewards")),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
               if (rewards[index] == "AR Characters") {
                // Navigate to a different page for AR Characters
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => VrCharacter(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              } else {
                // Default reward detail navigation
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => rd.RewardDetailPage(reward: rewards[index]),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.card_giftcard, size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(rewards[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
