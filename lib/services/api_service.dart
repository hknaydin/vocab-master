import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _dictionaryApiUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';
  final String _rapidApiUrl = 'https://wordsapiv1.p.rapidapi.com/words';
  final String _rapidApiKey = 'YOUR_RAPIDAPI_KEY'; // Replace with your RapidAPI key

  Future<Map<String, dynamic>> fetchWordDefinition(String word) async {
    try {
      final response = await http.get(Uri.parse('$_dictionaryApiUrl/[0m$word'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch word definition');
      }
    } catch (e) {
      print('Error fetching word definition: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> fetchSynonymsAndAntonyms(String word) async {
    var retries = 3;
    while (retries > 0) {
      try {
        final response = await http.get(Uri.parse('$_rapidApiUrl/$word'), headers: {
          'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
          'x-rapidapi-key': _rapidApiKey,
        });
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed to fetch synonyms and antonyms');
        }
      } catch (e) {
        print('Error fetching synonyms and antonyms: $e');
        retries--;
        if (retries == 0) {
          throw Exception('Failed to fetch synonyms and antonyms after multiple attempts.');
        }
      }
    }
    return {};
  }
}