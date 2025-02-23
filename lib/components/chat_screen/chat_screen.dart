import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import '../../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService chatService = ChatService();
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');
  bool _isLoading = false;

  void _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, userMessage);
      _isLoading = true; // Show loading indicator
    });

    try {
      String aiResponse = await chatService.chatWithAI(message.text);

      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Uuid().v4(),
        text: aiResponse,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    } catch (e) {
      final errorMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Uuid().v4(),
        text: "⚠️ Error: Unable to get a response from the AI.",
      );

      setState(() {
        _messages.insert(0, errorMessage);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF76B4B5),
        title: const Text(
          "HabitDoc AI Chatbot",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              showUserAvatars: true,
              showUserNames: true,
              avatarBuilder: (user) {
                return CircleAvatar(
                  radius: 18,
                  backgroundColor: user.id == 'bot' ? Color(0xFF2E535E) : Color(0xFF367BC1),
                  child: Icon(
                    user.id == 'bot' ? Icons.medical_services : Icons.person,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
