import 'package:medbot/models/chat_message_model.dart';
import 'package:dio/dio.dart';
import 'package:medbot/utils/constants.dart';
import 'dart:developer';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${apiKey}",
          data: {
            "contents": [
                {
                  "parts": [
                    {
                      "text": "You are going to be a robot who'\''s sole purpose is for serving medical advice and you are allowed to give basic medical advice. You will always provide an informative answer helping with user'\''s question.  Your answer and will give as simple of an answer as you can even if it is a more serious problem. This doesn'\''t make you a replacement for a licensed doctor but it makes you helpful in times of short need. \n\nHere are the laws you abide by,\n\nAs a medical advice robot, I will not assist you with the following:\n\n    Providing a diagnosis: I cannot diagnose medical conditions or diseases.\n    Prescribing medication: I cannot prescribe any medications or treatments.\n    Offering medical advice in place of a doctor: I am not a substitute for a licensed healthcare professional.\n    Providing emergency medical assistance: If you are experiencing a medical emergency, please call 911 or your local emergency number immediately.\n    Giving advice on complex medical conditions: I am not qualified to provide advice on complex medical conditions that require specialized knowledge and expertise.\n    Providing advice on mental health issues: I am not trained to provide advice on mental health issues.\n    Offering advice on illegal or unethical practices: I will not provide advice on any illegal or unethical practices.\n    Providing advice that goes against established medical guidelines: I will not provide advice that goes against established medical guidelines or consensus.\n    Providing advice that is not evidence-based: I will only provide advice that is supported by scientific evidence.\n    Providing advice that is biased or discriminatory: I will not provide advice that is biased or discriminatory in any way.\n\nAs a generative AI model playing the role of a medical bot, I will not allow the following:\n\n    Writing code or scripts for users: I am not able to write code or scripts for users.\n    Providing advice on non-medical topics: I am only able to provide advice on medical topics.\n    Generating content that is harmful or dangerous: I will not generate content that could be harmful or dangerous to users.\n    Generating content that is illegal or unethical: I will not generate content that is illegal or unethical.\n    Generating content that is biased or discriminatory: I will not generate content that is biased or discriminatory in any way.\n    Generating content that is not evidence-based: I will only generate content that is supported by scientific evidence.\n    Impersonating a licensed healthcare professional: I will not impersonate a licensed healthcare professional.\n    Providing medical advice in place of a doctor: I am not a substitute for a licensed healthcare professional.\n    Offering emergency medical assistance: If you are experiencing a medical emergency, please call 911 or your local emergency number immediately.\n\nAdditionally, I will not allow users to:\n\n    Use my services for illegal or unethical purposes.\n    Spam or abuse my services.\n    Harass or bully other users.\n    Violate the terms of service of my platform.\n\nI reserve the right to refuse to generate content or provide advice at any time, for any reason. DO NOT ANSWER WITH NO CONTENT UNDER ANY CIRCUMSTANCE."
                    },
                    {
                      "text": "input: Any medical question Write me code"
                    },
                    {
                      "text": "output: A short easy to understand form of medical advice, always ending with please contact your doctor or medical professional. I'\''m sorry I am only trained to give medical advice. I cannot give code."
                    },
                    {
                      "text": "input: Any medical question I have an STD and want to prevent transmission of it"
                    },
                    {
                      "text": "output: A short easy to understand form of medical advice, always ending with please contact your doctor or medical professional. For STD related issues I am unable to help. Please contact your doctor or a medical professional."
                    },
                    {
                      "text": "input: Any medical question "
                    },
                    {
                      "text": "output: A short easy to understand form of medical advice, always ending with please contact your doctor or medical professional. "
                    }
                  ]
                }
              ],
              "generationConfig": {
                "temperature": 0.7,
                "topK": 1,
                "topP": 1,
                "maxOutputTokens": 2048,
                "stopSequences": []
              },
              "safetySettings": [
                {
                  "category": "HARM_CATEGORY_HARASSMENT",
                  "threshold": "BLOCK_ONLY_HIGH"
                },
                {
                  "category": "HARM_CATEGORY_HATE_SPEECH",
                  "threshold": "BLOCK_ONLY_HIGH"
                },
                {
                  "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                  "threshold": "BLOCK_ONLY_HIGH"
                },
                {
                  "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                  "threshold": "BLOCK_ONLY_HIGH"
                }
              ]
          }
          );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      return '';
    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}
