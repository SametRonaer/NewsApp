import '../widgets/app_drawer.dart';

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
  static final routeName = "/feedScreen";
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _currentNewsPaper = NewsPapers.CnnNews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gündem"),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          HorizontalListOfNewsPapers(_switchCurrentNewsPaper),
          FutureBuilder(
              future: _loadNewsPaperProvider(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Container(
                          height: 400,
                          width: 400,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : _loadNewsPaper()),
        ],
      ),
    );
  }

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

  Widget _loadNewsPaper() {
    if (_currentNewsPaper == NewsPapers.CnnNews) {
      return Consumer<CnnNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(newsObject.news[index]);
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
              return FeedListTile(newsObject.news[index]);
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
              return FeedListTile(newsObject.news[index]);
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
              return FeedListTile(newsObject.news[index]);
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
