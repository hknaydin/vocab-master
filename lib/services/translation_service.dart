import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey;
  final String apiEndpoint = "https://translation.googleapis.com/language/translate/v2";

  TranslationService(this.apiKey);

  Future<Map<String, dynamic>> translate(List<String> texts, {String targetLanguage = 'tr'}) async {
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'q': texts,
        'target': targetLanguage,
        'format': 'text',
        'key': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to translate text: ${response.statusCode} ${response.body}');
    }
  }

  List<String> parseTranslations(Map<String, dynamic> response) {
    final translations = response['data']['translations'];
    return List<String>.from(translations.map((t) => t['translatedText']));
  }
}