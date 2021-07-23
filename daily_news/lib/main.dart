import 'package:daily_news/providers/bbc_news.dart';
import 'package:daily_news/providers/cnn_news.dart';
import 'package:daily_news/providers/haberturkNews.dart';
import 'package:daily_news/providers/ntv_news.dart';
import 'package:daily_news/screens/feed_screen.dart';
import 'package:daily_news/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CnnNews()),
        ChangeNotifierProvider(create: (_) => NtvNews()),
        ChangeNotifierProvider(create: (_) => BBCNews()),
        ChangeNotifierProvider(create: (_) => HaberturkNews())
      ],
      child: MaterialApp(
        home: FeedScreen(),
      ),
    );
  }
}
