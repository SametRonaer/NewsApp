import '../providers/bbc_news.dart';
import '../models/news.dart';
import '../providers/cnn_news.dart';
import '../providers/haberturkNews.dart';
import '../providers/ntv_news.dart';
import '../widgets/horizontal_list.dart';
import 'package:flutter/material.dart';
import '../constants/dummy_data.dart';
import '../widgets/feed_list_tile.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<NtvNews>(context, listen: false).getMainNews(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<NtvNews>(
                    builder: (ctx, newsObject, child) {
                      return Column(
                        children: [
                          Container(
                              child: HorizontalList(),
                              height: 120,
                              width: double.infinity),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (ctx, index) {
                                return FeedListTile(
                                  newsTitle: newsObject.news[index].title,
                                  newsDescription:
                                      newsObject.news[index].description,
                                  newsImageUrl: newsObject.news[index].imageUrl,
                                  newsUrl: newsObject.news[index].newsUrl,
                                );
                              },
                              itemCount: newsObject.news.length,
                            ),
                          ),
                        ],
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
