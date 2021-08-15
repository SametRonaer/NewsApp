import 'dart:async';

import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/feed_screen.dart';
import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  bool _selectedNewsPapersEmpty = true;
  String nextRoute;

  @override
  Widget build(BuildContext context) {
    // print("Selection screen");
    checkNewsPapers();
    _waitUntilTheAnimation(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset("assets/images/ezgif.gif", gaplessPlayback: false),
    );
  }

  Future<void> checkNewsPapers() async {
    var selectedNewsPapers =
        await DBHelper.getData(DBHelper.selectedNewsPapersTableName);
    _selectedNewsPapersEmpty = selectedNewsPapers.length == 0;
    if (_selectedNewsPapersEmpty) {
      nextRoute = NewspaperSelectionScreen.routeName;
    } else {
      nextRoute = FeedScreen.routeName;
    }
  }

  void _waitUntilTheAnimation(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(nextRoute);
    });
  }
}