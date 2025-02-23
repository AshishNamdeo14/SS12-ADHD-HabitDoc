import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraProvider with ChangeNotifier {
  List<CameraDescription> _cameras = [];

  List<CameraDescription> get cameras => _cameras;

  Future<void> loadCameras() async {
    _cameras = await availableCameras();
    notifyListeners();
  }
}
