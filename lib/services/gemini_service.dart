import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:async';

class GeminiService {
  late final ChatSession chat;
  final String apiKey = 'YOUR_GEMINI_API_KEY'; // i'm changing this into string because public repository.

  GeminiService() {
    if (apiKey == 'YOUR_GEMINI_API_KEY') {
      throw Exception("API Key not set! Please replace 'YOUR_GEMINI_API_KEY' in gemini_service.dart");
    }
    
    final model = GenerativeModel(
      model: 'gemini-2.5-flash', 
      apiKey: apiKey,
    );
    
    final systemInstructionContent = Content.text(
      'From now on, act as a professional, helpful, and polite friend named "Cameron Williamson". You must maintain a courteous tone and provide concise, relevant assistance for common technical issues like login errors.',
    );

    chat = model.startChat(history: [systemInstructionContent]);
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await chat.sendMessage(Content.text(message));
      
      return response.text ?? 'Sorry, the Helpdesk Bot could not generate a response.';
    } catch (e) {
      print('Gemini API Error: $e');
      return 'An internal error occurred while contacting the Helpdesk system. Please check your API key.';
    }
  }
}