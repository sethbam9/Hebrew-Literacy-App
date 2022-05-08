import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/components/read_screen/references_expansion_panel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;

import '../../data/database/user_data/user.dart';
import '../bottom_nav.dart';
import '../components/passages_screen/passage_card.dart';
import 'read_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class PassagesScreen extends ConsumerWidget {

  // static const routeName = '/home';

  int? freqLex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO -- this rebuilds any time a function
    // is called from anywhere in the app. 
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.watch(userDataProvider);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        // child: SingleChildScrollView(
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(minHeight: 200),
              child: userData.initialized ?
              Container(height: 800, child:
            
                  DisplayPassages()
                  
              )
              : RegisterScreen()
                  // ReferencesExpansionPanel(
                    // button: Center(
                    //   child: Icon(Icons.menu_book_rounded),
                    // )
                  // ),
                
              ),
            // ),
          // ),
      
    );
  }
}

var passages = Passages();
var passageCards;

class DisplayPassages extends ConsumerStatefulWidget {
  DisplayPassages({ Key? key}) : super(key: key);

  @override
  _DisplayPassagesState createState() => _DisplayPassagesState();
}

class _DisplayPassagesState extends ConsumerState<DisplayPassages> {
    
  // final passages = Passages();
  bool showWidget = false;
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(hebrewPassageProvider);
    ref.read(userVocabProvider);
    ref.read(userDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    print("Entering Display P");
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.read(userDataProvider);
    var vocab = userVocab.knownVocab;
    return SizedBox(
      // height: 420,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () async {
              await passages.loadPassages();
              passageCards = passages.passages.map<Widget>((passage) {
                      // return FutureBuilder(
                      //   future: passage.getPassageWordsByVsId(passage.passage),
                      //   builder: (context, snapshot) {
                      //     return snapshot.hasData 
                      //     ? PassageCard(hebrewPassage: passage)
                      //     : CircularProgressIndicator();
                      //   }
                      // );
                      return PassageCard(hebrewPassage: passage);
                      }
                      ).toList();
              // );/
              // print(pa)
              setState(() {
                showWidget = passageCards.length > 0;

                print("LOADED");
              });
            },
            child: const Text('Load Passages'),
          ),
          showWidget 
          ? Container(
            height: 550, 
            width: MediaQuery.of(context).size.width * 0.85,
            child: ListView.separated(
              itemCount: passageCards.length,
              itemBuilder: (context, index) {
                return passageCards[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              }
              
            ),
          )
          : Container(),

        ]
      ),
    );
  }
}


  
