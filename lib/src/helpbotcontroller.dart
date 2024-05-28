import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HelpbotController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxString chatHistory = RxString("");

  final TextEditingController textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _auth.currentUser;
    _currentUser.listen((user) async {
      if (user != null) {
        await loadChatHistory();
      }
    });
  }

  Future<void> loadChatHistory() async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final chatRef =
          _firestore.collection('users').doc(uid).collection('chatHistory');
      final chatSnapshot =
          await chatRef.orderBy('timestamp', descending: true).get();
      chatHistory.value = "";
      for (var doc in chatSnapshot.docs) {
        final data = doc.data();
        final message = "${data['role']}: ${data['message']}\n";
        chatHistory.value += message;
      }
    }
  }

  Future<String> _askQuestion(String question) async {
    // Replace "YOUR_API_KEY" with your actual Google Generative AI API key
    const String apiKey = "AIzaSyBbzbViHnvW4fJamrYr6FxWythUVXdSYMs";
    const String url =
        "https://language.googleapis.com/v1/projects/<project_id>/locations/global/models/<model_id>/generateText";
    final Map<String, String> headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json"
    };
    final String body = jsonEncode({
      "inputs": [
        {"text": question}
      ],
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String generatedText = data["generations"][0]["text"];
      await saveMessage("You", question);
      await saveMessage("Bukoni", generatedText);
      return generatedText;
    } else {
      return "Error: ${response.statusCode}";
    }
  }

  Future<void> saveMessage(String role, String message) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final chatRef =
          _firestore.collection('users').doc(uid).collection('chatHistory');
      await chatRef.add({
        'role': role,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  void sendMessage() async {
    final String question = textController.text.trim();
    if (question.isNotEmpty) {
      chatHistory.value += "You: $question\n"; // Update chatHistory directly
      textController.clear();
      final String answer = await _askQuestion(question);
      chatHistory.value += "Bukoni: $answer\n"; // Update chatHistory directly
    }
  }
}
