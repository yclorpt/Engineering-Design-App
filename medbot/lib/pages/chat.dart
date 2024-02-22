import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
 

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _userMessage = TextEditingController();

  static const apiKey = 'AIzaSyAt0dBsZMs0FmAi_SQjLRiuEcNAIdmlmpg';

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    final content = [Content.text(message)];
    final response = await model.generateContent(content);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Medbot")),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Expanded(
                flex: 15,
                child: TextFormField(
                  controller: _userMessage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                    label: const Text("Enter your message"),
                  ),
                ),
              ),
            ),
            Spacer(),
            IconButton(
              padding: const EdgeInsets.all(15),
              iconSize: 30,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.send),
            )
          ],
        )
      ])
    );
  }}