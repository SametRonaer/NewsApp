import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/providers/birgun_news.dart';
import 'package:daily_newspapers/providers/cumhuriyet_news.dart';
import 'package:daily_newspapers/providers/dunya_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/milliyet_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';

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
        ));
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
    } else if (_currentNewsPaper == AllNewsPapers.HurriyetNews) {
      return Provider.of<HurriyetNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.CumhuriyetNews) {
      return Provider.of<CumhuriyetNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.BirgunNews) {
      return Provider.of<BirgunNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.DunyaNews) {
      return Provider.of<DunyaNews>(context, listen: false).getMainNews();
    } else if (_currentNewsPaper == AllNewsPapers.MilliyetNews) {
      return Provider.of<MilliyetNews>(context, listen: false).getMainNews();
    }else if (_currentNewsPaper == AllNewsPapers.SabahNews) {
      return Provider.of<SabahNews>(context, listen: false).getMainNews();
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
    } else if (_currentNewsPaper == AllNewsPapers.HurriyetNews) {
      return Consumer<HurriyetNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              print(newsObject.news[index]);
              return FeedListTile(newsObject.news[index]);
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == AllNewsPapers.CumhuriyetNews) {
      return Consumer<CumhuriyetNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(newsObject.news[index]);
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == AllNewsPapers.BirgunNews) {
      return Consumer<BirgunNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(newsObject.news[index]);
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == AllNewsPapers.DunyaNews) {
      return Consumer<DunyaNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(newsObject.news[index]);
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == AllNewsPapers.MilliyetNews) {
      return Consumer<MilliyetNews>(builder: (ctx, newsObject, child) {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return FeedListTile(newsObject.news[index]);
            },
            itemCount: newsObject.news.length,
          ),
        );
      });
    } else if (_currentNewsPaper == AllNewsPapers.SabahNews) {
      return Consumer<SabahNews>(builder: (ctx, newsObject, child) {
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
