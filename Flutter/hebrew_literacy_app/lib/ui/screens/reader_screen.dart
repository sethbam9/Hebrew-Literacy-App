import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/reader_screen/reader_screen.dart';
import '../../data/providers/hebrew_passage.dart';



class ReaderScreen extends StatelessWidget {
  const ReaderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _hebrewPassageFuture = Provider.of<HebrewPassage>(
      context, listen: false).getHebrewWords();

    return FutureBuilder(
      future: _hebrewPassageFuture,
      builder: (ctx, snapshot) => 
      // Make sure the data is loaded. 
      snapshot.connectionState == ConnectionState.waiting 
      ? const Center(
        child: CircularProgressIndicator()
      )
      : Stack(
        children: [
          PassageDisplay(hebrewPassageFuture: _hebrewPassageFuture),
          Consumer<HebrewPassage>(
            builder: (ctx, hebrewPassage, _) =>
              hebrewPassage.hasSelection
                ? WordExpansionPanel(hebrewWord: hebrewPassage.selectedWord!)
                : Text('NA',
                    style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.normal
                  ),)
          )
      ],
    )
    );
  }
}