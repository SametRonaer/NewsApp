import 'package:daily_newspapers/constants/theme_mode.dart';
import 'package:daily_newspapers/screens/feed_screen.dart';
import 'package:daily_newspapers/screens/news_of_category_screen.dart';
import 'package:daily_newspapers/screens/saved_news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
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
                NewsOfCategoryScreen.routeName),
            Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor.withOpacity(0.5)),
            SizedBox(height: 10),
            _getDrawerButton(context, Icons.bookmark, "Kaydedilen Haberler",
                SavedNewsScreen.routeName),
            _getDarkModeButton(context, Icons.dark_mode, "Koyu Tema"),
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
        icon: Icon(icons, color: Theme.of(ctx).buttonColor),
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

  Widget _getDarkModeButton(BuildContext ctx, IconData icons, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextButton.icon(
          icon: Icon(icons, color: Theme.of(ctx).buttonColor),
          label: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(ctx).accentColor,
            ),
          ),
          onPressed: () {
            setState(() {
              Provider.of<ThemesOfApp>(context, listen: false).changeTheme();
            });
            Navigator.of(ctx).pop();
          }),
    );
  }
}
