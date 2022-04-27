import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/hebrew_passage.dart';
import '../../../data/models/models.dart';

// REMOVE LATER --> make theme class
import 'package:google_fonts/google_fonts.dart';


/// Builds a RichText containing all of the word objects that will be displayed
/// for a given passage. Each word is placed in a TextSpan such that its attributes 
/// can be accessed via a gesture detector. 
class PassageDisplay extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // If HebrewPassage.words is populated, generate a TextSpan
    // with all of the words -- otherwise display a message.
    final _hebrewPassage = ref.watch(hebrewPassageProvider);
    /// TODO REMOVE!
    return Column(
      children: [
        SizedBox(height: 65,),
        Expanded(
          child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              children: _buildTextSpans(_hebrewPassage, ref)
            ),
            textDirection: TextDirection.rtl,
          ),
      ),
        ),
      ]
    );
  }


  /// Takes a [HebrewPassage] instance and uses its data to construct
  /// a list of [TextSpan] that construct the [RichText] in [PassageDisplay].
  List<TextSpan>? _buildTextSpans(HebrewPassage hebrewPassage, ref) {

    var textDisplay = ref.watch(textDisplayProvider);
    var userVocab = ref.watch(userVocabProvider);
    List<TextSpan> hebrewPassageTextSpans = [];
    List<Word> words = hebrewPassage.words;
    // List to keep track of words that are joined, such as וְלַחֹ֖שֶׁךְ
    List<Word> joinedWords = [];
    // int curParagraph 
    int curVerse = -1; //words.first.vsIdBHS!;
    // int curSentence
    int curClause = -1; 
    int curPhrase = -1; 
    var newLine = TextSpan(text: '\n');
    var spacing = TextSpan(text: '      ');

    // Iterate over all words in the passage. 
    for (var i = 0; i < words.length; i++) {
      // The current word.
      var word = words[i];
      bool newVerse = false;
      bool newClause = false;
      // Add verse divisions. 
      if (textDisplay.verse && word.vsBHS != curVerse) {
        if (curVerse != -1) {
          hebrewPassageTextSpans.add(newLine);
        }
        newVerse = true;
        curVerse = word.vsBHS!;
        // Add verse number.
        var verseNumText = TextSpan(
            children:[
              WidgetSpan(
                alignment: PlaceholderAlignment.bottom,
                child: Text(
                  " ${word.vsBHS.toString()} ",
                  style: _wordStyle.copyWith(
                    fontSize: TxtTheme.verseSize,    
                    fontWeight: FontWeight.bold
                  )
                )
              )
            ]
          );
        hebrewPassageTextSpans.add(verseNumText);
      }

      // Add clause divisions. 
      if (textDisplay.clause && word.clauseId != curClause) {
        if (curClause != -1 && !newVerse) {
          hebrewPassageTextSpans.add(newLine);
          // hebrewPassageTextSpans.add(spacing);
        }
        curClause = word.clauseId!;
        // Maybe add other clause data. 
        // hebrewPassageTextSpans.add(TextSpan(text: "clause"));
        // hebrewPassageTextSpans.add(newLine);
      }

      // Add clause divisions. 
      if (textDisplay.phrase && word.phraseId != curPhrase) {
        if (curPhrase != -1) {
          hebrewPassageTextSpans.add(newLine);
        }
        curPhrase = word.phraseId!;
        // Maybe add other phrase data. 
        hebrewPassageTextSpans.add(TextSpan(text: "phrase"));
        hebrewPassageTextSpans.add(newLine);
      }

      // The following conditional evaluates if the current word stands alone or is 
      // part of a compound. If it is a compound, we continue iterating over words until
      // joinedWords is filled and then generate a TextSpan for each word, so that if
      // a word in the compound is selected, the whole compound will be affected. 

      // We are in a compound, therefore store the word and skip to the next iteration.
      if (word.trailer == null) {
        joinedWords.add(word);
        continue;

      // If the previous word has no trailer, we've reached the end of a compound.
      } else if (i > 0 && words[i-1].trailer == null) {
        // Add the current word as the last in the compound.
        joinedWords.add(word);
        // Create a TextSpan for each word in the compound. 
        for (var _word in joinedWords) {
          var _wordSpan = _createWordSpan(_word, userVocab, hebrewPassage, joinedWords);
          hebrewPassageTextSpans.add(_wordSpan);
        }
        // Add the compound's trailer. 
        var _trailerSpan = TextSpan(
          text: word.trailer,
          style: _wordStyle
        );
        hebrewPassageTextSpans.add(_trailerSpan);
        // Reset joinedWords.
        joinedWords = [];

      // Otherwise, the current word is not a compound, so we build it's TextSpan. 
      } else {
        // Build the word's text. 
        var _wordSpan = _createWordSpan(word, userVocab, hebrewPassage, [word]);
        // Build the word's trailer. 
        var _trailerSpan = TextSpan(
          text: word.trailer,
          style: _wordStyle
        ); 
        hebrewPassageTextSpans.add(_wordSpan);
        hebrewPassageTextSpans.add(_trailerSpan);
      }
      
    }
    return hebrewPassageTextSpans;
  }


  // The default styling for a word, changed via copyWith. 
  var _wordStyle = GoogleFonts.notoSerifHebrew(
      color: TxtTheme.normColor,
      fontSize: TxtTheme.normSize,
      fontWeight: TxtTheme.normWeight,
  );

  /// Takes a [Word], [UserVocab], [HebrewPassage] instance, and 
  /// [joinedWords], signifying if it's a single or compound word.
  /// If it isn't a compund word, then joinedWords = [\word].
  /// Returns a [TextSpan] formatted according to data in the 
  /// UserVocab and HebrewPassage providers. 
  TextSpan _createWordSpan(word, userVocab, hebrewPassage, List joinedWords) {
    // Current word's lexeme.
    Lexeme lex = hebrewPassage.lex(word.lexId!);
    // Change the word's color if it is a proper noun.
    // TODO: get user feedback on a good frequency for coloring proper nouns. 
    Color wordColor = (lex.speech == 'nmpr' && lex.freqLex! < 100) 
      ? TxtTheme.propNounColor 
      : TxtTheme.normColor;
    // Color the word differently if it's unknown and not a proper noun. 
    if (lex.speech != 'nmpr' && !userVocab.isKnown(lex)) {
      wordColor = TxtTheme.unknownColor!;
    }
    // Change the word's weight if it is selected.
    FontWeight weight = joinedWords.any((w) => w.isSelected) 
      ? TxtTheme.selWeight 
      : TxtTheme.normWeight;
    // Return a text span with the customized word formatting. 
    return TextSpan(
      text: word.text ?? '',
      style:_wordStyle.copyWith(
        color: wordColor,
        fontWeight: weight,
      ),
      recognizer: TapGestureRecognizer()
      ..onTap = () {
        hebrewPassage.toggleWordSelection(word);
      }
    );
  }

}