import 'package:daily_newspapers/screens/saved_news_screen.dart';

import 'providers/bbc_news.dart';
import 'providers/cnn_news.dart';
import 'providers/haberturk_news.dart';
import 'providers/ntv_news.dart';
import 'screens/feed_screen.dart';
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
        theme: ThemeData(
          primaryColor: Colors.red.shade900,
          accentColor: Colors.black,
        ),
        home: SafeArea(child: FeedScreen()),
        routes: {SavedNewsScreen.routeName: (ctx) => SavedNewsScreen()},
      ),
    );
  }
}
