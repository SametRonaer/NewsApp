import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/helpers/db_helper.dart';

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
  var _currentNewsPaper = AllNewsPapers.CnnNews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gündem"),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _getData(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : _loadNewsPaper()),
                  ],
                );
        },
      ),
    );
  }

  Future<void> _getData() async {
    var dataList = await DBHelper.getData(DBHelper.selectedNewsPapers);
    //print(dataList);
  }

  void _switchCurrentNewsPaper(AllNewsPapers newsPaper) {
    setState(() {
      _currentNewsPaper = newsPaper;
    });
  }

  Future _loadNewsPaperProvider() {
    if (_currentNewsPaper == AllNewsPapers.CnnNews) {
      return Provider.of<CnnNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.BBCNews) {
      return Provider.of<BBCNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.HaberturkNews) {
      return Provider.of<HaberturkNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.NtvNews) {
      return Provider.of<NtvNews>(context, listen: false).getMainNews();
    }
    return null;
  }

  Widget _loadNewsPaper() {
    if (_currentNewsPaper == AllNewsPapers.CnnNews) {
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
    } else if (_currentNewsPaper == AllNewsPapers.BBCNews) {
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
    } else if (_currentNewsPaper == AllNewsPapers.HaberturkNews) {
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
    } else if (_currentNewsPaper == AllNewsPapers.NtvNews) {
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
