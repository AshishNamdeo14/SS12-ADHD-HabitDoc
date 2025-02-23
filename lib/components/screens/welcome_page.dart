import 'package:flutter/material.dart';
import 'package:ss12/components/rewards_screen/RewardPage.dart';
import 'package:ss12/components/screens/avatar_select.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF76B4B5),
        body: SafeArea(
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Cartoon Doctor Image as CircleAvatar
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CircleAvatar(
                        radius: 75, // Adjust radius as needed
                        backgroundColor:
                            Colors.white, // Background color for the circle
                        child: ClipOval(
                          child: Image.asset(
                            'assets/dr_dope.png', // Ensure this image is in the assets folder
                            height: 150, // Adjust as needed
                            width: 150, // Adjust as needed
                            fit:
                                BoxFit
                                    .cover, // Ensures the image covers the circle
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Welcome!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "I'm Dr.Dope, and I am here to help you detoxify your bad habits.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1C4753),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvatarSelectionScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
