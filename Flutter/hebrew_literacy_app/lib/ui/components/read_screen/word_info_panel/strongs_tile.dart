import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

import '../../../../data/models/strongs.dart';
import '../word_expansion_panel.dart';


class StrongsTile extends ConsumerStatefulWidget {
  const StrongsTile({Key? key}) : super(key: key);

  @override
  _StrongsTileState createState() => _StrongsTileState();
}

class _StrongsTileState extends ConsumerState<StrongsTile> {
  var strongsData;
  void loadData(future) {
    setState(() {
      strongsData = future;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    return ExpansionTile(
        backgroundColor: MyTheme.bgColor,
        collapsedBackgroundColor: MyTheme.bgColor,
        textColor: MyTheme.selectedTileText,
        collapsedTextColor: MyTheme.greyText,
        onExpansionChanged: (expanding) {
          if (expanding) {
            loadData(hebrewPassage.getStrongs(word!));
          }
        },
        title: Text('DEFINITION'),
        children: [
          Container(
              height: 100,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                child: FutureBuilder<List<Strongs>>(
                    future: strongsData,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.done
                            ? RichText(text: _buildStrongsText(snapshot.data!))
                            : CircularProgressIndicator()),
              ))
        ]);
  }


  TextSpan _buildStrongsText(List<Strongs> strongsData) {
    List<TextSpan> allDefinitions = [];
    allDefinitions
        .add(TextSpan(text: "Strongs: ${strongsData.first.strongsId}\n"));
    for (var strongs in strongsData) {
      if (strongs != null) {
        var definitions = strongs.definition!.split('<br>');
        for (var def in definitions) {
          allDefinitions.add(TextSpan(text: def + '\n'));
        }
      }
    }
    return TextSpan(children: allDefinitions);
  }
}
