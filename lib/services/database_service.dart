import 'package:hive/hive.dart';

class DatabaseService {
  Box _box;

  Future<void> initialize() async {
    // Initialize Hive if not already initialized
    if (!Hive.isBoxOpen('wordsBox')) {
      _box = await Hive.openBox('wordsBox');
    }
  }

  Future<void> addWord(String name, bool isFavorite) async {
    await _box.put(name, {'isFavorite': isFavorite});
  }

  Map<String, dynamic>? getWordByName(String name) {
    return _box.get(name);
  }

  List<Map<String, dynamic>> getAllWords() {
    return _box.toMap().entries.map((entry) {
      return {entry.key: entry.value};
    }).toList();
  }

  Future<void> deleteWord(String name) async {
    await _box.delete(name);
  }

  List<String> getFavoriteWords() {
    return _box.toMap().entries
        .where((entry) => entry.value['isFavorite'] == true)
        .map((entry) => entry.key)
        .toList();
  }

  Future<void> updateFavoriteStatus(String name, bool isFavorite) async {
    if (_box.containsKey(name)) {
      await _box.put(name, {'isFavorite': isFavorite});
    }
  }
}