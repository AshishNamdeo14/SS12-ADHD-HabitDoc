import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';

class ArCharacterScreen extends StatefulWidget {
  const ArCharacterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArCharacterScreenState createState() => _ArCharacterScreenState();
}

class _ArCharacterScreenState extends State<ArCharacterScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  ARNode? characterNode;

void onARViewCreated(ARSessionManager sessionManager, ARObjectManager objectManager) {
  arSessionManager = sessionManager;
  arObjectManager = objectManager;

  arSessionManager.onInitialize(
    showFeaturePoints: false,
    showPlanes: true,
    showWorldOrigin: true,
    handlePans: true,
    handleRotation: true,
  );

  _addCharacter(); // Function to add 3D character
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View 3D Character in AR")),
      // body: ARView(
      //   // onARViewCreated: onARViewCreated,
      // ),
    );
  }



  Future<void> _addCharacter() async {
    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/character.gltf", // Ensure you have this model in assets
      scale: Vector3(0.3, 0.3, 0.3),
      position: Vector3(0.0, 0.0, -1.0), // 1 meter in front of user
    );
    bool? didAdd = await arObjectManager.addNode(newNode);
    if (didAdd == true) {
      setState(() {
        characterNode = newNode;
      });
    }
  }
}
