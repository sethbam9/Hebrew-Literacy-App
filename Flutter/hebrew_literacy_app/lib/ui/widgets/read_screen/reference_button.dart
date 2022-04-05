import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';
import '../../screens/read_screen.dart';

// Code inspired by https://github.com/31Carlton7/elisha/blob/master/lib/src/ui/views/bible_view/bible_view.dart

class ReferenceButton extends ConsumerWidget {
  const ReferenceButton ({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      
      final passage = ref.watch(hebrewPassageProvider);

      return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headline4!.fontSize!
        ),
  
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
          // color: Theme.of(context).inputDecorationTheme.fillColor,
          color: Colors.blueAccent
        ),
        child: Text(
          passage.book.name! + ' ' + passage.words[0].chBHS.toString(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
        ),
      );
    }
  }