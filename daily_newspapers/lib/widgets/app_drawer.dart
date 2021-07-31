import 'package:daily_newspapers/screens/feed_screen.dart';
import 'package:daily_newspapers/screens/news_of_category_screen.dart';
import 'package:daily_newspapers/screens/saved_news_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text(
                "iris",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 24),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            SizedBox(height: 140),
            _getDrawerButton(
                context, Icons.article_rounded, "Gündem", FeedScreen.routeName),
            _getDrawerButton(context, Icons.language, "Dünya",
                NewsOfCategoryScreen.routeName, Categories.World),
            _getDrawerButton(context, Icons.money_outlined, "Ekonomi",
                NewsOfCategoryScreen.routeName, Categories.Economy),
            _getDrawerButton(context, Icons.sports_soccer, "Spor",
                NewsOfCategoryScreen.routeName, Categories.Sport),
            _getDrawerButton(context, Icons.bookmark, "Kaydedilen Haberler",
                SavedNewsScreen.routeName),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerButton(
      BuildContext ctx, IconData icons, String title, String routeName,
      [Categories category = null]) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextButton.icon(
        icon: Icon(icons, color: Theme.of(ctx).primaryColor),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(ctx).accentColor,
          ),
        ),
        onPressed: () =>
            Navigator.of(ctx).pushNamed(routeName, arguments: category),
      ),
    );
  }
}
