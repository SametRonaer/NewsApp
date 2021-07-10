import 'package:flutter/material.dart';
import '../constants/dummy_data.dart';
import '../widgets/feed_list_tile.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed Page")),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return FeedListTile(
            newsTitle: dummyData[index].title,
            newsDescription: dummyData[index].description,
            newsImageUrl: dummyData[index].imageUrl,
            newsUrl: dummyData[index].newsUrl,
          );
        },
        itemCount: dummyData.length,
      ),
    );
  }
}
