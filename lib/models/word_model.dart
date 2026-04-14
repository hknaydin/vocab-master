import 'package:hive/hive.dart';

part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel {
  @HiveField(0)
  final String englishWord;

  @HiveField(1)
  final String turkishTranslation;

  @HiveField(2)
  final String partOfSpeech;

  @HiveField(3)
  final String definition;

  @HiveField(4)
  final List<String> exampleSentences;

  @HiveField(5)
  final List<String> synonyms;

  @HiveField(6)
  final List<String> antonyms;

  WordModel({
    required this.englishWord,
    required this.turkishTranslation,
    required this.partOfSpeech,
    required this.definition,
    required this.exampleSentences,
    required this.synonyms,
    required this.antonyms,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      englishWord: json['englishWord'],
      turkishTranslation: json['turkishTranslation'],
      partOfSpeech: json['partOfSpeech'],
      definition: json['definition'],
      exampleSentences: List<String>.from(json['exampleSentences']),
      synonyms: List<String>.from(json['synonyms']),
      antonyms: List<String>.from(json['antonyms']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'englishWord': englishWord,
      'turkishTranslation': turkishTranslation,
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'exampleSentences': exampleSentences,
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }
}