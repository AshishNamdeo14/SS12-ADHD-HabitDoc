import 'dart:convert'; 
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = "AIzaSyC3wAduWsNuYg0Wp6fGDC3WoUEYryiE1eA"; // Use .env later
  final String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  final List<Map<String, String>> _chatHistory = []; // Stores conversation history

  Future<String> chatWithAI(String userMessage) async {
    // Add user message to chat history
    _chatHistory.add({"role": "user", "content": userMessage});

    // Prepare conversation history for AI
    List<Map<String, String>> messages = [
      {
        "role": "system",
        "content": "You are Doctor Dopamine, also known as Dr. Dope! 🎩💊 A friendly, motivating AI doctor."
      }
    ];

    // Only add introduction if it's the first message
    if (_chatHistory.length == 1) {
      messages.add({
        "role": "assistant",
        "content": "Hey there, superstar! 🌟 I'm Doctor Dopamine, but my friends call me Dr. Dope! I have a PhD in Doomscrolling 📜, and I'm here to help you **stay focused** and **crush your goals**! 🚀"
      });
    }

    // Add user and past AI messages to keep context
    messages.addAll(_chatHistory);

    final response = await http.post(
      Uri.parse("$apiUrl?key=$apiKey"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": messages.map((m) => {"text": m["content"]}).toList()
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String aiResponse = data['candidates'][0]['content']['parts'][0]['text'];

      // Add AI response to chat history
      _chatHistory.add({"role": "assistant", "content": aiResponse});

      return aiResponse;
    } else {
      return "⚠️ Oops! Something went wrong with Dr. Dope's response.";
    }
  }
}