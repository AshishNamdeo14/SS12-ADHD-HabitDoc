import 'package:flutter/material.dart';
import 'package:ss12/components/vr_characters/vr_Character.dart';

class Arrewards extends StatefulWidget {
  const Arrewards({super.key});

  @override
  State<Arrewards> createState() => _ArrewardsState();
}

class _ArrewardsState extends State<Arrewards> {
  final int currentPoints = 50; // Change this to test unlocking
  final List<int> milestones = List.generate(100, (index) => (index + 1) * 10); // Generate 100 milestones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Background Color
      appBar: AppBar(
        title: const Text("Achievement Path"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SizedBox(
          height: 150, // Adjust height to fit circles in a row
          width: 1000, // Adjust width to accommodate all 100 circles
          child: Stack(
            children: milestones.asMap().entries.map((entry) {
              int index = entry.key;
              int pointsRequired = entry.value;
              bool isUnlocked = currentPoints >= pointsRequired;

              double leftOffset = 40.0 * index; // Positioning circles horizontally (smaller gap)
              double topOffset = 50.0; // Center circles vertically in the stack

              return Positioned(
                top: topOffset,
                left: leftOffset,
                child: GestureDetector(
                  onTap: isUnlocked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VrCharacter(),
                            ),
                          );
                        }
                      : null,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isUnlocked ? Colors.green : Colors.grey,
                        child: Text(
                          pointsRequired.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      if (index != milestones.length - 1)
                        Positioned(
                          top: topOffset + 25,
                          left: leftOffset + 25,
                          child: Container(
                            width: 40,
                            height: 5,
                            color: isUnlocked ? Colors.green : Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// class RewardDetailPage extends StatelessWidget {
//   final int points;

//   const RewardDetailPage(this.points, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[800],
//       appBar: AppBar(title: Text("Reward: $points Points")),
//       body: Center(
//         child: Text(
//           "Details for $points points reward!",
//           style: const TextStyle(fontSize: 20, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
