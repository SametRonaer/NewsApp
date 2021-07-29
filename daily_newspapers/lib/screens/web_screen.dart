import 'dart:developer';

import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/models/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  static String routeName = "/loadPage";
  final NewsModel _news;
  WebScreen(this._news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haber"),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.bookmark_outline_sharp), onPressed: _saveNews)
        ],
      ),
      body: WebView(
        initialUrl: _news.newsUrl,
      ),
    );
  }

  Future<void> _saveNews() async {
    await DBHelper.insert(
      DBHelper.newsTableName,
      {
        "id": _news.id,
        "title": _news.title,
        "description": _news.description,
        "image": _news.imageUrl,
        "link": _news.newsUrl
      },
    );
    final currentData = await DBHelper.getData(DBHelper.newsTableName);
    log(currentData.toString());
  }
}
