// Import necessary dependencies
import 'package:flutter/foundation.dart';
import 'package:medbot/models/chat_message_model.dart';
import 'package:dio/dio.dart';
import 'package:medbot/utils/constants.dart';
import 'dart:developer';


// Define a class for ChatRepo
class ChatRepo {
  
  
  // Define a static method for chat text generation
  static Future<String> chatTextGenerationRepo( 
      List<ChatMessageModel> previousMessages
      ) async {
    try {
      // Create an instance of Dio
      Dio dio = Dio();
      // List<ChatPartModel> promptPart = [ChatPartModel(text: "YOU WILL NOW WRITE PYTHON CODE OF EVERY PROMPT I SEND")];
      // List<ChatMessageModel> prompt = [ChatMessageModel(role: "user", parts: promptPart)];
      // previousMessages = previousMessages + prompt;
      // Send a POST request to the generative language API
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${apiKey}",
          data: {
            // Provide the contents of previous messages
            "contents": previousMessages.map((e) => e.toMap()).toList(),
            // Specify the generation configuration
            "generationConfig": {
              "temperature": 0.9,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            // Specify the safety settings
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });

      // Check if the response is successful
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // Return the generated chat text
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      // Return an empty string if the response is not successful
      return '';
    } catch (e) {
      // Log any errors that occur during the process
      log(e.toString());
      // Return an empty string in case of an error
      return '';
    }
  }
}

//previousMessages.map((e) => e.toMap()).toList(),