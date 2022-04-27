import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'my_app.dart';
import 'data/models/user_vocab.dart';
import 'data/models/models.dart';

import 'data/providers/providers.dart';

void main() async {
  // https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database
  // Initialize hive before using any boxes.
  await Hive.initFlutter();
  // Open the peopleBox
  Hive.registerAdapter(UserVocabAdapter());
  // await Hive.openBox<UserVocab>('userVocab');
  await Books.getBooks();
  await AllLexemes.loadAllLexemes();
  runApp(ProviderScope(child: MyApp()));
}