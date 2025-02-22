import 'package:flutter/material.dart';
import 'package:ss12/components/vr_characters/character_detail.dart';

class VrCharacter extends StatefulWidget {
  const VrCharacter({super.key});

  @override
  State<VrCharacter> createState() => _VrCharacterState();
}

class _VrCharacterState extends State<VrCharacter> {
  void openCharacter(String name, IconData icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetail(name: name, icon: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RewardButton(
              name: 'Golden Helmet',
              icon: Icons.shield_outlined,
              onTap: () => openCharacter('Golden Helmet', Icons.shield_outlined),
            ),
            const SizedBox(height: 20),
            RewardButton(
              name: 'Mystic Sword',
              icon: Icons.abc_outlined, // This requires "cupertino_icons" package
              onTap: () => openCharacter('Mystic Sword', Icons.abc_outlined),
            ),
            const SizedBox(height: 20),
            RewardButton(
              name: 'Shadow Cloak',
              icon: Icons.visibility_off,
              onTap: () => openCharacter('Shadow Cloak', Icons.visibility_off),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const RewardButton({super.key, required this.name, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 30, color: Colors.white),
      label: Text(name, style: const TextStyle(fontSize: 18, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

