import '../screens/web_screen.dart';
import 'package:flutter/material.dart';

class FeedListTile extends StatelessWidget {
  final String newsTitle;
  final String newsDescription;
  final String newsImageUrl;
  final String newsUrl;

  FeedListTile(
      {this.newsTitle, this.newsDescription, this.newsImageUrl, this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        try {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebScreen(newsUrl),
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
            title: Text(newsTitle),
            subtitle: Row(
              children: [
                Expanded(child: Text(newsDescription)),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    newsImageUrl,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
