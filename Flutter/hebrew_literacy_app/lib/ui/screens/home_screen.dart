import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/passage.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/components/read_screen/references_expansion_panel.dart';
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
    var hebrewPassage = ref.read(hebrewPassageProvider);
    var passageData = ref.read(passageDataProvider);
    if (!hebrewPassage.isLoaded) {
      ref.read(hebrewPassageProvider).getPassageWordsByRef(1, 1);
    }

    String welcomeText = userData.justRegistered() 
      ? "Hello ${userData.name},\n\nWelcome to ${APP_NAME}!"
      : "Welcome back, ${userData.name}";

    print("Home built");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 800,
        width: double.infinity,
        // child: SingleChildScrollView(
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(minHeight: 200),
              child: Container(height: 450, child:
            
                  GestureDetector(
                    onTap: () async { 
                      await passageData.initializePassages(20); print('tapped');
                      },
                    child: Text(welcomeText,
                    style: Theme.of(context).textTheme.headline5, 
                    textAlign: TextAlign.center,
                    ),
                  )
                  
              )
        
                
              ),
            // ),
          // ),
      
    );
  }
 
}

