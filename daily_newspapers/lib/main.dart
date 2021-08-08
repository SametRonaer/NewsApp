import 'package:daily_newspapers/dummy_feed_screen.dart';
import 'package:daily_newspapers/providers/birgun_news.dart';
import 'package:daily_newspapers/providers/cumhuriyet_news.dart';
import 'package:daily_newspapers/providers/dunya_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/milliyet_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';
import 'package:daily_newspapers/screens/launch_screen.dart';
import 'package:daily_newspapers/screens/news_of_category_screen.dart';
import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
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
  final bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CnnNews()),
        ChangeNotifierProvider(create: (_) => NtvNews()),
        ChangeNotifierProvider(create: (_) => BBCNews()),
        ChangeNotifierProvider(create: (_) => HaberturkNews()),
        ChangeNotifierProvider(create: (_) => HurriyetNews()),
        ChangeNotifierProvider(create: (_) => CumhuriyetNews()),
        ChangeNotifierProvider(create: (_) => BirgunNews()),
        ChangeNotifierProvider(create: (_) => DunyaNews()),
        ChangeNotifierProvider(create: (_) => MilliyetNews()),
        ChangeNotifierProvider(create: (_) => SabahNews()),
      ],
      child: MaterialApp(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          primaryColor: Colors.red.shade900,
          accentColor: Colors.black,
          backgroundColor: Colors.white,
          cardColor: Colors.white,
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.red.shade900,
          accentColor: Colors.white,
          cardColor: Colors.grey.shade800,
          backgroundColor: Colors.red.shade800,
        ),
        //home: DummyFeedScreen(),
        home: SafeArea(child: LaunchScreen()),
        // home: SafeArea(child: NewspaperSelectionScreen()),
        //home: SafeArea(child: FeedScreen()),
        routes: {
          SavedNewsScreen.routeName: (ctx) => SavedNewsScreen(),
          FeedScreen.routeName: (ctx) => FeedScreen(),
          NewsOfCategoryScreen.routeName: (ctx) => NewsOfCategoryScreen(),
          NewspaperSelectionScreen.routeName: (ctx) =>
              NewspaperSelectionScreen(),
        },
      ),
    );
  }
}
