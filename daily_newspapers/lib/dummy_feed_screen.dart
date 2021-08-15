import 'package:daily_newspapers/providers/birgun_news.dart';
import 'package:daily_newspapers/providers/cumhuriyet_news.dart';
import 'package:daily_newspapers/providers/dunya_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/milliyet_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';
import 'package:daily_newspapers/providers/star_news.dart';
import 'package:daily_newspapers/providers/t24_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DummyFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("onpressed");
          Provider.of<T24News>(context, listen: false).getMainNews();
        },
      ),
    );
  }
}
