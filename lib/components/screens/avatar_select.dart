import 'package:flutter/material.dart';
import '../../../../../../main/lib/user_details_screen.dart'; // Import the next screen

class AvatarSelectionScreen extends StatefulWidget {
  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? selectedAvatarIndex;

  final List<String> avatarImages = [
    'lib/assets/avatar1.png',
    'lib/assets/avatar2.png',
    'lib/assets/avatar3.png',
    'lib/assets/avatar4.png',
    'lib/assets/avatar5.png',
    'lib/assets/avatar6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF76B4B5),
      appBar: AppBar(
        title: Text('Choose Your Avatar'),
        backgroundColor: Color(0xFF76B4B5),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 10,
              children: List.generate(avatarImages.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatarIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            selectedAvatarIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(avatarImages[index]),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1C4753),
              ),
              onPressed:
                  selectedAvatarIndex != null
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => UserDetailsScreen(
                                  avatarImage:
                                      avatarImages[selectedAvatarIndex!],
                                ),
                          ),
                        );
                      }
                      : null,
              child: Text(
                'Confirm Selection',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
