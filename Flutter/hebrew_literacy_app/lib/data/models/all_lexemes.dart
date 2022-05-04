import '../models/models.dart';
import '../database/hb_db_helper.dart';

class AllLexemes {
  static late final List<Lexeme> _lexemes;

  static get lexemes {
    return [..._lexemes];
  }

  static Future<void> loadAllLexemes() async {
    _lexemes = await HebrewDatabaseHelper().getAllLexemes();
  }

  static List<Lexeme> getLexemesInPassage(List<Word> words) {
    Set uniqueWords = {};
    for (var w in words) {
      uniqueWords.add(w.lexId);
    }
    var _lexemes = lexemes.where((lex) => uniqueWords.contains(lex.id)).toList();
    return _lexemes;
  }
}