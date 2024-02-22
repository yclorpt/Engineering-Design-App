import 'dart:convert';

// Represents a chat message with a role and a list of chat parts
class ChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  ChatMessageModel({
    required this.role,
    required this.parts,
  });

  // Converts the ChatMessageModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  // Constructs a ChatMessageModel object from a map
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] ?? '',
      parts: List<ChatPartModel>.from(
          map['parts']?.map((x) => ChatPartModel.fromMap(x))),
    );
  }

  // Converts the ChatMessageModel object to a JSON string
  String toJson() => json.encode(toMap());

  // Constructs a ChatMessageModel object from a JSON string
  factory ChatMessageModel.fromJson(String source) =>
      ChatMessageModel.fromMap(json.decode(source));
}

// Represents a part of a chat message with text
class ChatPartModel {
  final String text;

  ChatPartModel({
    required this.text,
  });

  List<ChatMessageModel> messages = [];

  // Converts the ChatPartModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  // Constructs a ChatPartModel object from a map
  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      text: map['text'] ?? '',
    );
  }

  // Converts the ChatPartModel object to a JSON string
  String toJson() => json.encode(toMap());

  // Constructs a ChatPartModel object from a JSON string
  factory ChatPartModel.fromJson(String source) =>
      ChatPartModel.fromMap(json.decode(source));
}
