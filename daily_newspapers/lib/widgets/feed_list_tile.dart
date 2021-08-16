import 'package:daily_newspapers/models/news.dart';

import '../screens/web_screen.dart';
import 'package:flutter/material.dart';

class FeedListTile extends StatelessWidget {
  final NewsModel news;

  FeedListTile(this.news);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        try {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebScreen(news),
            ),
          );
        } catch (e) {
          print(e);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 5,
          child: ListTile(
            title: _loadNewsTitle(context, news.title),
            subtitle: Row(
              children: [
                Expanded(
                    child: _loadNewsDescription(context, news.description)),
                Container(
                  width: 100,
                  height: 100,
                  child: _loadNewsImage(news.imageUrl),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Image _loadNewsImage(String imageUrl) {
    try {
      return Image.network(imageUrl);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Text _loadNewsTitle(BuildContext context, String newsTitle) {
    try {
      return Text(
        newsTitle,
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.w600),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Text _loadNewsDescription(BuildContext context, String newsDescription) {
    try {
      return Text(
        newsDescription,
        style: TextStyle(color: Theme.of(context).accentColor),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
}
