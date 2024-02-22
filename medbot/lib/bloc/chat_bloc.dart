import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:medbot/models/chat_message_model.dart';
import 'package:medbot/repos/chat_repo.dart';

part 'chat_event.dart'; // Importing the 'chat_event.dart' file as a part
part 'chat_state.dart'; // Importing the 'chat_state.dart' file as a part

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages = []; // List to store chat messages
  bool generating = false; // Flag to indicate if text generation is in progress

  FutureOr<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: "You've got a medical advice robot here, ready to offer basic guidance. Keep in mind, I can't diagnose or prescribe medications. I'm not a replacement for a doctor, especially in emergencies. Complex issues, mental health, illegal activities, biased advice, or anything against medical guidelines is a no-go. I can't generate code, discuss non-medical topics, create harmful content, or impersonate healthcare professionals. Please don't misuse me, spam, harass others, or violate terms of service. I can decline advice for any reason. In emergencies, always seek professional help.${event.inputMessage}")])); // Adding user's input message to the list
    emit(ChatSuccessState(messages: messages)); // Emitting a new state with updated messages
    generating = true; // Setting the generating flag to true
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages); // Generating text using the ChatRepo
    if (generatedText.isNotEmpty) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)])); // Adding generated text to the list
      emit(ChatSuccessState(messages: messages)); // Emitting a new state with updated messages
    }
    generating = false; // Setting the generating flag to false
  }
}
