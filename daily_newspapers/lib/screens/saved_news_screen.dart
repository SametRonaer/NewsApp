import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/models/news.dart';
import 'package:daily_newspapers/widgets/app_drawer.dart';
import 'package:daily_newspapers/widgets/feed_list_tile.dart';
import 'package:flutter/material.dart';
import '../helpers/share_news.dart';

class SavedNewsScreen extends StatefulWidget {
  static final routeName = "/savedNews";

  @override
  _SavedNewsScreenState createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  final List<FeedListTile> _savedNewsList = [];
  List _savedNews;

  Future<void> _getSavedNews() async {
    _savedNews = await DBHelper.getData(DBHelper.savedNewsTableName);
    _savedNews.forEach((element) {
      NewsModel news = NewsModel(
        id: element["id"],
        title: element["title"],
        description: element["description"],
        imageUrl: element["image"],
        newsUrl: element["link"],
      );
      _savedNewsList.add(FeedListTile(news));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Kaydedilen Haberler")),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _getSavedNews(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    key: ValueKey(_savedNews[index]["id"]),
                    direction: DismissDirection.horizontal,
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 40,
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                          ),
                        ),
                      ],
                    ),
                    confirmDismiss: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        return _showDeleteDialog(_savedNews[index]["title"]);
                      } else {
                        return _shareNews(_savedNews[index]["link"]);
                      }
                    },
                    child: GestureDetector(
                      child: _savedNewsList[index],
                      onLongPress: () {
                        _showDeleteDialog(_savedNews[index]["title"]);
                      },
                    ),
                  );
                },
                itemCount: _savedNewsList.length,
              ),
      ),
    );
  }

  Future<bool> _shareNews(String newsUrl) async {
    await ShareNewsWithOtherApps.shareNews(newsUrl);
    return false;
  }

  Future<bool> _showDeleteDialog(String newsTitle) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Bu haberi silmek istedğinize emin misiniz?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      await DBHelper.deleteData(
                          DBHelper.savedNewsTableName, newsTitle);
                      setState(() {
                        _savedNewsList.clear();
                      });
                      Navigator.of(ctx).pop();
                      return true;
                    },
                    child: Text("Sil", style: TextStyle(color: Colors.black))),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      return false;
                    },
                    child:
                        Text("İptal", style: TextStyle(color: Colors.black))),
              ],
            ));
  }
}
