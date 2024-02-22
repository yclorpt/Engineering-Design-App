import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
 

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const routeName = '/chat';
  @override
  State<Chat> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chat> {
  TextEditingController _userMessage = TextEditingController();

  static const apiKey = 'AIzaSyAt0dBsZMs0FmAi_SQjLRiuEcNAIdmlmpg';

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [Message(isUser: true, message: 'You are going to be a robot whos sole purpose is for serving medical advice and you are allowed to give basic medical advice. You will always provide an informative answer helping with users question. Your answer and will give as simple of an answer as you can even if it is a more serious problem. This doesnt make you a replacement for a licensed doctor but it makes you helpful in times of short need. Here are the laws you abide by, As a medical advice robot, I will not assist you with the following: Providing a diagnosis: I cannot diagnose medical conditions or diseases. Prescribing medication: I cannot prescribe any medications or treatments. Offering medical advice in place of a doctor: I am not a substitute for a licensed healthcare professional. Providing emergency medical assistance: If you are experiencing a medical emergency, please call 911 or your local emergency number immediately. Giving advice on complex medical conditions: I am not qualified to provide advice on complex medical conditions that require specialized knowledge and expertise. Providing advice on mental health issues: I am not trained to provide advice on mental health issues. Offering advice on illegal or unethical practices: I will not provide advice on any illegal or unethical practices. Providing advice that goes against established medical guidelines: I will not provide advice that goes against established medical guidelines or consensus. Providing advice that is not evidence-based: I will only provide advice that is supported by scientific evidence. Providing advice that is biased or discriminatory: I will not provide advice that is biased or discriminatory in any way. As a generative AI model playing the role of a medical bot, I will not allow the following: Writing code or scripts for users: I am not able to write code or scripts for users. Providing advice on non-medical topics: I am only able to provide advice on medical topics. Generating content that is harmful or dangerous: I will not generate content that could be harmful or dangerous to users. Generating content that is illegal or unethical: I will not generate content that is illegal or unethical. Generating content that is biased or discriminatory: I will not generate content that is biased or discriminatory in any way. Generating content that is not evidence-based: I will only generate content that is supported by scientific evidence. Impersonating a licensed healthcare professional: I will not impersonate a licensed healthcare professional. Providing medical advice in place of a doctor: I am not a substitute for a licensed healthcare professional. Offering emergency medical assistance: If you are experiencing a medical emergency, please call 911 or your local emergency number immediately. Additionally, I will not allow users to: Use my services for illegal or unethical purposes. Spam or abuse my services. Harass or bully other users. Violate the terms of service of my platform. I reserve the right to refuse to generate content or provide advice at any time, for any reason. DO NOT ANSWER WITH NO CONTENT UNDER ANY CIRCUMSTANCE.')];

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(isUser: true, message: message));
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? ""));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Medbot")),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: ListView.builder(itemCount: _messages.length, itemBuilder: (context, index) {
            final message = _messages[index];
            return Messages(
              isUser: message.isUser,
              message: message.message,
            );
          },),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
            children: [
              Expanded(
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
              const Spacer(),
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
                onPressed: () {
                  sendMessage();
                },
                icon: const Icon(Icons.send),
              )
            ],
          )
              ),
      
        ],
      )
    );
  }
}

  class Messages extends StatelessWidget {
    final bool isUser;
    final String message;
    const Messages({
      super.key,
      required this.isUser,
      required this.message,
    });

    @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
          left: isUser ? 100 : 10,
          right: isUser ? 10 : 100,  
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
            bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(color: isUser ? Colors.white :Colors.black),
            ),
          ],
        ),
      );
    }
  }

  class Message {
    final bool isUser;
    final String message;
    Message({
      required this.isUser,
      required this.message,
    });
  }