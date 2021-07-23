import 'package:daily_news/providers/bbc_news.dart';
import 'package:daily_news/models/news.dart';
import 'package:daily_news/providers/cnn_news.dart';
import 'package:daily_news/providers/haberturkNews.dart';
import 'package:daily_news/providers/ntv_news.dart';
import 'package:flutter/material.dart';
import '../constants/dummy_data.dart';
import '../widgets/feed_list_tile.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed Page")),
      body: FutureBuilder(
        future:
            Provider.of<HaberturkNews>(context, listen: false).getMainNews(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<HaberturkNews>(
                    builder: (ctx, newsObject, child) {
                      return ListView.builder(
                        itemBuilder: (ctx, index) {
                          return FeedListTile(
                            newsTitle: newsObject.news[index].title,
                            newsDescription: newsObject.news[index].description,
                            newsImageUrl: newsObject.news[index].imageUrl,
                            newsUrl: newsObject.news[index].newsUrl,
                          );
                        },
                        itemCount: newsObject.news.length,
                      );
                    },
                  ),
      ),
    );
  }
}

// FeedListTile(
// newsTitle: dummyData[index].title,
// newsDescription: dummyData[index].description,
// newsImageUrl: dummyData[index].imageUrl,
// newsUrl: dummyData[index].newsUrl,
// );
