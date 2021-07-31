import 'package:daily_newspapers/models/news.dart';
import 'package:daily_newspapers/screens/web_screen.dart';
import 'package:flutter/material.dart';

enum CellType {
  small,
  large,
}

class NewsGridTile extends StatelessWidget {
  final List<NewsModel> newsList;
  int newsOrder = 0;

  NewsGridTile(this.newsList);

  @override
  Widget build(BuildContext context) {
    // return _getNews(context);
    return ListView.builder(
      itemBuilder: (ctx, i) => _getNews(context),
      itemCount: newsList.length,
    );
  }

  Widget _getNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          if (newsList.length - 1 >= newsOrder)
            Row(
              children: [
                _getNewsCell(newsList[newsOrder], context, CellType.large),
              ],
            ),
          if (newsList.length - 1 >= newsOrder + 1)
            Row(
              children: [
                _getNewsCell(newsList[newsOrder + 1], context, CellType.small),
                SizedBox(width: 10),
                if (newsList.length - 1 >= newsOrder + 2)
                  _getNewsCell(
                      newsList[newsOrder + 2], context, CellType.small),
                SizedBox(height: 10),
              ],
            ),
        ],
      ),
    );
  }

  Widget _getNewsCell(NewsModel news, BuildContext context, CellType cellType) {
    double imageHeight = cellType == CellType.large ? 180 : 135;
    newsOrder += 1;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 270,
          color: Colors.white,
          child: InkWell(
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
            child: Column(children: [
              Container(
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.cover,
                ),
                height: imageHeight,
                width: double.infinity,
              ),
              Text(
                news.title,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Text(
                  news.description,
                  overflow: TextOverflow.fade,
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
