import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss12/components/common/camera/CameraProvider.dart';
import 'package:ss12/components/common/splashScreen/SplashScreen.dart';

void main() async {
  final cameraProvider = CameraProvider();
  await cameraProvider.loadCameras(); // Fetch available cameras

  try {
    await Firebase.initializeApp(); // Initialize Firebase
  } catch (e) {
    print("Error: ${e.toString()}"); // Print error if Firebase fails to initialize
  }

   runApp(
    ChangeNotifierProvider(
      create: (_) => cameraProvider,
      child: const MyApp(),
    ),
  ); // Pass cameras to MyApp
}

class MyApp extends StatelessWidget { // Store cameras

  const MyApp({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Pass cameras to SplashScreen
    );
  }
}
