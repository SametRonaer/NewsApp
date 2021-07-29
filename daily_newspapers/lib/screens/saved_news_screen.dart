import 'package:flutter/material.dart';

class SavedNewsScreen extends StatelessWidget {
  static final routeName = "/savedNews";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: LinearProgressIndicator()),
    );
  }
}
