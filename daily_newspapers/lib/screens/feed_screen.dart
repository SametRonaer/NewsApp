import '../models/rss_response.dart';
import '../providers/bbc_news.dart';
import '../providers/cnn_news.dart';
import '../providers/haberturk_news.dart';
import '../providers/ntv_news.dart';
import '../widgets/horizontal_list.dart';
import 'package:flutter/material.dart';
import '../widgets/feed_list_tile.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _currentNewsPaper = NewsPapers.BBCNews;
  void _switchCurrentNewsPaper(NewsPapers newsPaper) {
    setState(() {
      _currentNewsPaper = newsPaper;
    });
  }

  Future _loadNewsPaperProvider() {
    if (_currentNewsPaper == NewsPapers.CnnNews) {
      return Provider.of<CnnNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == NewsPapers.BBCNews) {
      return Provider.of<BBCNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == NewsPapers.HaberturkNews) {
      return Provider.of<HaberturkNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == NewsPapers.NtvNews) {
      return Provider.of<NtvNews>(context, listen: false).getMainNews();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadNewsPaperProvider(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                          child: HorizontalList(_switchCurrentNewsPaper),
                          height: 120,
                          width: double.infinity),
                      _loadNewsPaper(),
                    ],
                  ),
      ),
    );
  }

  Widget _loadNewsPaper() {
    if (_currentNewsPaper == NewsPapers.CnnNews) {
      return Consumer<CnnNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(
                newsTitle: newsObject.news[index].title,
                newsDescription: newsObject.news[index].description,
                newsImageUrl: newsObject.news[index].imageUrl,
                newsUrl: newsObject.news[index].newsUrl,
              );
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == NewsPapers.BBCNews) {
      return Consumer<BBCNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(
                newsTitle: newsObject.news[index].title,
                newsDescription: newsObject.news[index].description,
                newsImageUrl: newsObject.news[index].imageUrl,
                newsUrl: newsObject.news[index].newsUrl,
              );
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == NewsPapers.HaberturkNews) {
      return Consumer<HaberturkNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(
                newsTitle: newsObject.news[index].title,
                newsDescription: newsObject.news[index].description,
                newsImageUrl: newsObject.news[index].imageUrl,
                newsUrl: newsObject.news[index].newsUrl,
              );
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == NewsPapers.NtvNews) {
      return Consumer<NtvNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(
                newsTitle: newsObject.news[index].title,
                newsDescription: newsObject.news[index].description,
                newsImageUrl: newsObject.news[index].imageUrl,
                newsUrl: newsObject.news[index].newsUrl,
              );
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else {
      return null;
    }
  }
}
