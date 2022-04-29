import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;

import '../../data/database/user_data/user.dart';
import '../bottom_nav.dart';
import 'read_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen ({ Key? key }) : super(key: key);

  static const routeName = '/home';

  int? freqLex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO -- this rebuilds any time a function
    // is called from anywhere in the app. 
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.watch(userDataProvider);
    // TODO: temp
    ref.read(hebrewPassageProvider).getPassageWordsByRef(1, 1);

    print("Home built");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 800,
        width: double.infinity,
        // child: SingleChildScrollView(
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(minHeight: 200),
              child: userData.initialized ?
              Container(height: 450, child:
            
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
 
  // Widget setVocab(context, userVocab) {
  //   return Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           SizedBox(height: 60,),
  //           Text('Enter the lexical range you have memorized.'),
  //           SizedBox(
  //             width: 200,
  //             child: TextField(
  //               onChanged: (newText) {freqLex = int.parse(newText);}
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             child: ElevatedButton(
  //               onPressed: () async {
  //                 await userVocab.initializeVocab(freqLex);
  //                 userVocab.load();
  //               },
  //               child: const Text('Submit'),
  //             ),
  //           ),
  //         ],
  //   );
  // }
}

var passages = Passages();

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
        children: [
          Text("Welcome back, ${userData.name}!"),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              userData.clearData();
              userVocab.clearData();
            },
            child: const Text('Clear User Data'),
          ),
          ElevatedButton(
            onPressed: () async {
              await passages.loadPassages();
              setState(() {
                showWidget = !showWidget;
                print("LOADED");
              });
            },
            child: const Text('Load Passages'),
          ),
          showWidget 
          ? Container(height: 300,
            child: SingleChildScrollView(
            // child: ConstrainedBox(
            //   constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
            // SizedBox(height: 450,
              child: Column(
                    children: 
                      passages.passages.map((passage) {
                        var unknown = passage.lexemes.where((l) => !vocab.contains(l.id)).toList();
                        var word = passage.words.first;
                        print("${unknown.length} / ${passage.lexemes.length}");
                        return Card(
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () async {
                              debugPrint('Card tapped.');
                              await ref.read(hebrewPassageProvider).getPassageWordsById(passage.words.first.id!, passage.words.last.id!);
                              ref.read(tabManagerProvider).goToTab(Screens.read.index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${passage.book.abbrOSIS} ${word.chBHS}:${word.vsBHS}-${passage.words.last.vsBHS}',
                                  textAlign: TextAlign.left,),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child:  Text("Words:")
                                      ),
                                      SizedBox(width: 5,),
                                      Text("${passage.words.length}"),
                                    ]
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child:  Text("Match:")
                                      ),
                                      SizedBox(width: 5,),
                                      Text("${((1 - unknown.length / passage.lexemes.length) * 100).toInt()}%")
                                    ]
                                  ),
                                  // Flexible(
                                  //   child: Text('$morph', softWrap:true, maxLines: 2,)
                                  // )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()
              ),
            // )
            ),
          )
          : Container(),

        ]
      ),
    );
  }
}


  
