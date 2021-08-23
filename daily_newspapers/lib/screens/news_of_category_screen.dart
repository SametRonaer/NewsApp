import 'package:daily_newspapers/models/news.dart';
import 'package:daily_newspapers/providers/cnn_news.dart';
import 'package:daily_newspapers/providers/haberturk_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/ntv_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';
import 'package:daily_newspapers/providers/star_news.dart';
import 'package:daily_newspapers/providers/takvim_news.dart';
import 'package:daily_newspapers/widgets/app_drawer.dart';
import 'package:daily_newspapers/widgets/news_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Categories {
  Sport,
  Economy,
  World,
  Daily,
}

class NewsOfCategoryScreen extends StatefulWidget {
  static final routeName = "/newsOfCategoryScreen";

  @override
  _NewsOfCategoryScreenState createState() => _NewsOfCategoryScreenState();
}

class _NewsOfCategoryScreenState extends State<NewsOfCategoryScreen> {
  Categories category;
  List<NewsModel> news = [];

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context).settings.arguments as Categories;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text(
            _getTitleOfAppBar(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder(
        future: _loadNews(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : NewsGridTile(news),
      ),
    );
  }

  Future<void> _loadNews() async {
    List<NewsModel> loadedNews;
    news.clear();

    if (category == Categories.Sport) {
      loadedNews =
          await Provider.of<CnnNews>(context, listen: false).getSportNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<NtvNews>(context, listen: false).getSportNews();
      _combineNews(loadedNews);
      loadedNews += await Provider.of<HaberturkNews>(context, listen: false)
          .getSportNews();
      _combineNews(loadedNews);
      loadedNews += await Provider.of<HurriyetNews>(context, listen: false)
          .getSportNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<SabahNews>(context, listen: false).getSportNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<TakvimNews>(context, listen: false).getSportNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<StarNews>(context, listen: false).getSportNews();
      _combineNews(loadedNews);
    } else if (category == Categories.World) {
      loadedNews =
          await Provider.of<CnnNews>(context, listen: false).getWorldNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<NtvNews>(context, listen: false).getWorldNews();
      _combineNews(loadedNews);
      loadedNews += await Provider.of<HaberturkNews>(context, listen: false)
          .getWorldNews();
      _combineNews(loadedNews);
      loadedNews += await Provider.of<HurriyetNews>(context, listen: false)
          .getWorldNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<SabahNews>(context, listen: false).getWorldNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<TakvimNews>(context, listen: false).getWorldNews();
      _combineNews(loadedNews);
      loadedNews +=
          await Provider.of<StarNews>(context, listen: false).getWorldNews();
      _combineNews(loadedNews);
    } else if (category == Categories.Economy) {
      loadedNews =
          await Provider.of<CnnNews>(context, listen: false).getEconomyNews();
      _combineNews(loadedNews);
      print(1);
      loadedNews +=
          await Provider.of<NtvNews>(context, listen: false).getEconomyNews();
      _combineNews(loadedNews);
      print(2);
      loadedNews += await Provider.of<HaberturkNews>(context, listen: false)
          .getEconomyNews();
      _combineNews(loadedNews);
      print(3);
      loadedNews += await Provider.of<HurriyetNews>(context, listen: false)
          .getEconomyNews();
      _combineNews(loadedNews);
      print(4);
      loadedNews +=
          await Provider.of<SabahNews>(context, listen: false).getEconomyNews();
      _combineNews(loadedNews);
      print(5);
      loadedNews += await Provider.of<TakvimNews>(context, listen: false)
          .getEconomyNews();
      _combineNews(loadedNews);
      print(6);
      loadedNews +=
          await Provider.of<StarNews>(context, listen: false).getEconomyNews();
      _combineNews(loadedNews);
      print(7);
    }
    news.shuffle();
  }

  void _combineNews(List<NewsModel> loadedNews) {
    int index = 0;
    if (loadedNews.length >= 9) {
      while (index < 9) {
        index++;
        news.add(loadedNews[index]);
      }
      loadedNews.clear();
    }
  }

  String _getTitleOfAppBar() {
    if (category == Categories.Economy) {
      return "Ekonomi";
    } else if (category == Categories.World) {
      return "Dünya";
    } else if (category == Categories.Sport) {
      return "Spor";
    }
    return null;
  }
}
