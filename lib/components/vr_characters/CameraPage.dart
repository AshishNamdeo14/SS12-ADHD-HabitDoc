import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ss12/components/common/camera/CameraProvider.dart';

class MyCamPage extends StatefulWidget {
  @override
  State<MyCamPage> createState() => _MyCamPageState();
}

class _MyCamPageState extends State<MyCamPage> {
  bool _isPermissionGranted = false;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      _initializeCamera();
    } else {
      setState(() {
        _isPermissionGranted = false;
      });
    }
  }

  Future<void> _initializeCamera() async {
    // Fetch the cameras list from the provider
    final cameras = Provider.of<CameraProvider>(context, listen: false).cameras;
    
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras[0], // Use the first available camera
        ResolutionPreset.medium,
      );

      try {
        await _cameraController!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        // Handle camera initialization error
        print('Error initializing camera: $e');
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _isPermissionGranted
            ? _isCameraInitialized
                ? Stack(
                    children: [
                      CameraPreview(_cameraController!), // Camera preview
                      Positioned(
                        bottom: 100, // Position the dummy character image
                        left: 100,
                        child: Image.asset(
                          'assets/doc_Front.png', // Your dummy character image
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator() // Loading indicator
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera, size: 100, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'Camera Permission Denied!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _requestCameraPermission,
                    child: const Text('Grant Permission'),
                  ),
                ],
              ),
      ),
    );
  }
}
