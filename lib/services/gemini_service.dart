import 'dart:convert';
import 'package:cine_bot/models/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel model;
  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Missing GEMINI_API_KEY in .env file');
    }

    model = GenerativeModel(model: 'gemini-2.5-pro', apiKey: apiKey);
  }
  
  Future<Message> getMovieResponse(String userMessage) async {
    final prompt =
        '''
      You are CineBot, a friendly AI that suggests a movie based on the user's preferences.
      User message: "$userMessage"
      Reply with conversational tone and include movie name, release year, and short synopsis. Don`t use formatting. Also reply on this formar:
      Reply in JSON like this, don't use formatting like ```json {}```:
      {
        "title": "movie name",
        "message": "your reply",
      }
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    final json = jsonDecode(response.text ?? "{}");
    final title = json['title'];
    final message = json['message'];
    return Message(text: message, isUser: false, title: title);
  }
}
