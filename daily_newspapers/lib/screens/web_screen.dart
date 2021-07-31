import 'dart:developer';
import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/helpers/share_news.dart';
import 'package:daily_newspapers/models/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  static String routeName = "/loadPage";
  final NewsModel _news;
  WebScreen(this._news);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Haber"),
          actions: [
            IconButton(icon: Icon(Icons.share), onPressed: _shareNews),
            IconButton(
                icon: Icon(Icons.bookmark_outline_sharp), onPressed: _saveNews)
          ],
        ),
        body: WebView(
          javascriptMode: JavascriptMode.disabled,
          initialUrl: widget._news.newsUrl,
        ));
  }

  Future<void> _shareNews() async {
    await ShareNewsWithOtherApps.shareNews(widget._news);
  }

  Future<void> _saveNews() async {
    await DBHelper.insert(
      DBHelper.newsTableName,
      {
        "id": widget._news.id,
        "title": widget._news.title,
        "description": widget._news.description,
        "image": widget._news.imageUrl,
        "link": widget._news.newsUrl
      },
    );
    final currentData = await DBHelper.getData(DBHelper.newsTableName);
    log(currentData.toString());
  }
}
