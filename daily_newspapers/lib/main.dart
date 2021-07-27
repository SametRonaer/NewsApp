import 'package:daily_newspapers/dummy_web_view.dart';
import 'package:daily_newspapers/widgets/feed_list_tile.dart';

import 'providers/bbc_news.dart';
import 'providers/cnn_news.dart';
import 'providers/haberturkNews.dart';
import 'providers/ntv_news.dart';
import 'screens/feed_screen.dart';
import 'screens/home_screen.dart';
import 'widgets/horizontal_list.dart';
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
        home: SafeArea(child: FeedScreen()),
        //home: DummyWebView(),
      ),
    );
  }
}
