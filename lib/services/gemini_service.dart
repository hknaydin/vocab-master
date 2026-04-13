import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  final String apiUrl = 'https://api.generativeai.google.com/v1';

  GeminiService(this.apiKey);

  String _buildSystemPrompt(List<String> words, List<String> synonyms) {
    return '''
      You are a helpful assistant focused on educational content. 
      Use the following words and synonyms to generate meaningful sentences:
      Words: ${words.join(', ')}
      Synonyms: ${synonyms.join(', ')}
    ''';
  }

  Future<String> generateSentence(List<String> words, List<String> synonyms) async {
    final prompt = _buildSystemPrompt(words, synonyms);
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/generate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'prompt': prompt,
          'temperature': 0.7,
          'max_output_tokens': 100,
          'stream': true,
        }),
      );

      if (response.statusCode == 200) {
        // Handle streaming response here if applicable
        return response.body; // Modify to handle actual streaming response as needed
      } else {
        throw Exception('Failed to generate sentence: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred while generating the sentence.';
    }
  }
}