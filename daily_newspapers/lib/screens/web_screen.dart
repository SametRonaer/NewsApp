import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/helpers/share_news.dart';
import 'package:daily_newspapers/models/news.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../helpers/detect_news_source.dart';

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
    final String newsSource = DetectNewsSource.getNewsSource(widget._news);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
          children: [
            _getNewspaperLogo(DetectNewsSource.newsPaperLogoUrl),
            SizedBox(width: 70),
            Expanded(child: Text(newsSource)),
          ],
        )),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: _shareNews),
          SaveNews(widget._news),
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.disabled,
        initialUrl: widget._news.newsUrl,
      ),
    );
  }

  Widget _getNewspaperLogo(String logoUrl) {
    return Container(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          logoUrl,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Future<void> _shareNews() async {
    await ShareNewsWithOtherApps.shareNews(widget._news.newsUrl);
  }
}

class SaveNews extends StatefulWidget {
  final NewsModel _news;

  SaveNews(this._news);

  @override
  _SaveNewsState createState() => _SaveNewsState();
}

class _SaveNewsState extends State<SaveNews> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchNewsInDatabase(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : IconButton(
                  icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_outline_sharp),
                  onPressed: _saveNews,
                ),
    );
  }

  Future<void> _saveNews() async {
    if (!_isSaved) {
      await DBHelper.insert(
        DBHelper.savedNewsTableName,
        {
          "id": widget._news.id,
          "title": widget._news.title,
          "description": widget._news.description,
          "image": widget._news.imageUrl,
          "link": widget._news.newsUrl
        },
      );
    } else {
      DBHelper.deleteData(DBHelper.savedNewsTableName, widget._news.title);
    }

    setState(() {
      _isSaved = !_isSaved;
    });
  }

  Future<void> searchNewsInDatabase() async {
    final savedNewsList = await DBHelper.getData(DBHelper.savedNewsTableName);
    savedNewsList.forEach((element) {
      if (element["link"] == widget._news.newsUrl) {
        if (!_isSaved) {
          setState(() {
            _isSaved = true;
          });
        }
      }
    });
  }
}
