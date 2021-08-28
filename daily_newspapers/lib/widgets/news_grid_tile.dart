import 'package:daily_newspapers/helpers/detect_news_source.dart';
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
  int _newsListLength = 0;
  final List<Widget> _newsCellWidgetsList = [];

  NewsGridTile(this.newsList);

  @override
  Widget build(BuildContext context) {
    _newsListLength = newsList.length;
    _getNews(context);
    return ListView.builder(
      itemBuilder: (ctx, i) => _newsCellWidgetsList[i],
      itemCount: _newsCellWidgetsList.length,
    );
  }

  void _getNews(BuildContext context) {
    while (_newsListLength > 0) {
      if (_newsListLength >= 3) {
        _newsCellWidgetsList.add(Padding(
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
                    _getNewsCell(
                        newsList[newsOrder + 1], context, CellType.small),
                    SizedBox(width: 10),
                    if (newsList.length - 1 >= newsOrder + 2)
                      _getNewsCell(
                          newsList[newsOrder + 2], context, CellType.small),
                    SizedBox(height: 10),
                  ],
                ),
            ],
          ),
        ));
        _newsListLength = _newsListLength - 3;
      } else if (_newsListLength == 2) {
        _newsCellWidgetsList.add(Padding(
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
                    _getNewsCell(
                        newsList[newsOrder + 1], context, CellType.small),
                    SizedBox(width: 10),
                  ],
                ),
            ],
          ),
        ));
        _newsListLength = _newsListLength - 2;
      } else if (_newsListLength == 1) {
        _newsCellWidgetsList.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              if (newsList.length - 1 >= newsOrder)
                Row(
                  children: [
                    _getNewsCell(newsList[newsOrder], context, CellType.large),
                  ],
                ),
            ],
          ),
        ));
        _newsListLength = _newsListLength - 1;
      }
    }
  }

  Widget _getNewsCell(NewsModel news, BuildContext context, CellType cellType) {
    double imageHeight = cellType == CellType.large ? 180 : 135;
    newsOrder += 1;
    final newsSource = DetectNewsSource.getNewsSource(news);
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 270,
          color: Theme.of(context).cardColor,
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
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(
                    news.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: Text(
                        newsSource,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
                height: imageHeight,
                width: double.infinity,
              ),
              Expanded(
                child: Text(
                  news.title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    news.description,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
