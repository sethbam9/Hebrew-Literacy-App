class WordConstants {

  static String table = 'word';

  static String wordId = 'wordId';
  static String book = 'book';
  static String chKJV = 'chKJV';
  static String vsKJV = 'vsKJV';
  static String vsIdKJV = 'vsIdKJV';
  static String chBHS = 'chBHS';
  static String vsBHS = 'vsBHS';
  static String vsIdBHS = 'vsIdBHS';
  // static String lang = 'lang'; -- Getting data from Lexeme
  // static String speech = 'speech';
  static String person = 'person';
  static String gender = 'gender';
  static String number = 'number';
  static String vTense = 'vTense';
  static String vStem = 'vStem';
  static String state = 'state';
  static String prsPerson = 'prsPerson';
  static String prsGender = 'prsGender';
  static String prsNumber = 'prsNumber';
  static String suffix = 'suffix';
  static String text = 'text';
  static String textCons = 'textCons';
  static String trailer = 'trailer';
  static String transliteration = 'transliteration';
  static String glossExt = 'glossExt';
  static String glossBSB = 'glossBSB';
  static String sortBSB = 'sortBSB';
  static String strongsId = 'strongsId';
  static String lexId = 'lexId';
  static String phraseId = 'phraseId';
  static String clauseAtomId = 'clauseAtomId';
  static String clauseId = 'clauseId';
  static String sentenceId = 'sentenceId';
  static String freqOcc = 'freqOcc';
  static String rankOcc = 'rankOcc';
  static String poetryMarker = 'poetryMarker';
  static String parMarker = 'parMarker';

  static List<String> cols = [
    wordId,
    book,
    chKJV,
    vsKJV,
    vsIdKJV,
    chBHS,
    vsBHS,
    vsIdBHS,
    // lang,
    // speech,
    person,
    gender,
    number,
    vTense,
    vStem,
    state,
    prsPerson,
    prsGender,
    prsNumber,
    suffix,
    text,
    textCons,
    trailer,
    transliteration,
    glossExt,
    glossBSB,
    sortBSB,
    strongsId,
    lexId,
    phraseId,
    clauseAtomId,
    clauseId,
    sentenceId,
    freqOcc,
    rankOcc,
    poetryMarker,
    parMarker,
  ];
}


class LexemeConstants {

  static String table = 'lex';

  static String lexId = 'lexId';
  static String language = 'language';
  static String speech = 'speech';
  static String nameType = 'nameType';
  static String lexSet = 'lexSet';
  static String lexText = 'lexText'; // NOTE
  static String gloss = 'gloss';
  static String freqLex = 'freqLex';
  static String rankLex = 'rankLex';
  
  static List<String> cols = [
    lexId,
    language,
    speech,
    nameType,
    lexSet,
    lexText,
    gloss,
    freqLex,
    rankLex
  ];
}


class PhraseConstants {

  static String table = 'phrase';

  static String phraseId = 'phraseId';
  static String determined = 'determined';
  static String function = 'function';
  static String phraseNumber = 'phraseNumber';
  static String phraseType = 'phraseType';
  
  static List<String> cols = [
    phraseId,
    determined,
    function,
    phraseNumber,
    phraseType
  ];
}


class ClauseAtomConstants {

  static String table = 'clauseAtom';

  static String clauseAtomId = 'clauseAtomId';
  static String code = 'code';
  static String paragraph = 'paragraph';
  static String tab = 'tab';
  static String clauseAtomType = 'clauseAtomType';
  
  static List<String> cols = [
    clauseAtomId,
    code,
    paragraph,
    tab,
    clauseAtomType
  ];
}


class ClauseConstants {

  static String table = 'clause';

  static String clauseId = 'clauseId';
  static String domain = 'domain';
  static String kind = 'kind';
  static String number = 'number';
  static String relation = 'relation';
  static String clauseType = 'clauseType';
  
  static List<String> cols = [
    clauseId,
    domain,
    kind,
    number,
    relation,
    clauseType
  ];
}


class LexClauseConstants {

  static String table = 'lexClause';
  
  static String lexId = 'lexId';
  static String clauseId = 'clauseId';
  static String clauseWeight = 'clauseWeight';

  static List<String> cols = [
    lexId,
    clauseId,
    clauseWeight
  ];
}


class StrongsConstants {
  
  static String table = 'strongs';

  static String strongsId = 'strongsId';
  static String lexeme = 'lexeme';
  static String transliterationSTEP = 'transliterationSTEP';
  static String morphCode = 'morphCode';
  static String glossSTEP = 'glossSTEP';
  static String definition = 'definition';

  static List<String> cols = [
    strongsId,
    lexeme,
    transliterationSTEP,
    morphCode,
    glossSTEP,
    definition
  ];
}


class PassageConstants {
  static String table = 'passage';

  static String passageId = 'passageId';
  static String wordCount = 'wordCount';
  static String weight = 'weight';
  static String startWordId = 'startWordId';
  static String endWordId = 'endWordId';

  static List<String> cols = [
    passageId,
    wordCount,
    weight,
    startWordId,
    endWordId
  ];
}

class BookConstants {

  static String table = 'book';

  static String bookId = 'bookId';
  static String chapters = 'chapters';
  static String abbrOSIS = 'abbrOSIS';
  static String abbrLEB = 'abbrLEB';
  static String bookName = 'bookName';
  static String bookNameHeb = 'bookNameHeb';
  static String tanakhSort = 'tanakhSort';

  static List<String> cols = [
    bookId,
    chapters,
    abbrOSIS,
    abbrLEB,
    bookName,
    bookNameHeb,
    tanakhSort
  ];
}
