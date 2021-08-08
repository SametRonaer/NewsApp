import 'dart:async';

import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _waitUntilTheAnimation(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset("assets/images/ezgif.gif", gaplessPlayback: false),
    );
  }

  void _waitUntilTheAnimation(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacementNamed(NewspaperSelectionScreen.routeName);
    });
  }
}
