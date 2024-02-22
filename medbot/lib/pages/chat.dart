import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medbot/bloc/chat_bloc.dart';
import 'package:medbot/models/chat_message_model.dart';
import 'package:medbot/widgets/bottom_nav_bar.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const routeName = '/chat';
  @override
  State<Chat> createState() => _HomePageState();
}

class _HomePageState extends State<Chat> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                scrollable: true,
                title: const Text('DISCLAIMER'),
                content: const Text('MedBot is an artificial intelligence (AI) designed to offer general medical advice. It is currently in beta development and should not be considered a substitute for professional medical guidance. Please use the information provided with caution.\n\nMedBot is not a replacement for professional medical advice, diagnosis, or treatment. Consult with your physician or qualified health provider for personalized guidance.\n\nMedBot is in beta development. While efforts are made for accuracy, it may not reflect the most current medical standards. Updates are ongoing to improve reliability.\n\nExercise discretion when interpreting MedBot''s advice. Do not solely rely on it for critical healthcare decisions. In emergencies, seek immediate medical assistance.\n\nUsers acknowledge and assume risks associated with relying on AI-generated medical advice. Developers are not liable for any damages resulting from its use.\n\nProvide feedback on discrepancies or concerns. Your input helps enhance the accuracy of MedBot.\n\nBy using MedBot, you agree to this disclaimer. If you disagree, refrain from using the application.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('I Understand.')
                    )
                ],
              )
              );
          }, 
          icon: const Icon(Icons.info)
          ),
        ]),
      bottomNavigationBar: const BottomNavBar(index: 1),
      extendBodyBehindAppBar: true,
        body: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 60,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MedBot",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                          ],
                        )),
                    Expanded(
                        child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(
                                bottom: 12, left: 16, right: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: messages[index].role == "user"
                                    ? Colors.blue
                                    : const Color.fromARGB(255, 153, 153, 153)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index].role == "user"
                                      ? "You:"
                                      : "MedBot:",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(height: 8),
                                Text(messages[index].parts.first.text),
                              ],
                            ));
                      },
                    )),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              child: Lottie.asset('assets/loader.json')),
                          const SizedBox(width: 20),
                          const Text("Loading...")
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Row(children: [
                        Expanded(
                            child: TextField(
                          controller: textEditingController,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              fillColor: Colors.white,
                              hintText: "Ask medical questions here!",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 80, 80, 80)),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                        )),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              chatBloc.add(ChatGenerateNewTextMessageEvent(
                                  inputMessage: text));
                            }
                          },
                          child: const CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.send, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ));
              default:
                return const SizedBox();
            }
          },
        ));
  }
}

