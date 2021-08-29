import 'package:daily_newspapers/constants/theme_mode.dart';
import 'package:daily_newspapers/screens/communication_screen.dart';
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
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    ThemeMode currentMode =
        Provider.of<ThemesOfApp>(context, listen: false).themeMode;
    if (currentMode == ThemeMode.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getDrawer();
  }

  Widget _getDrawer() {
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(
                  "Menü",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              isDarkMode
                  ? Image.asset("assets/images/iris_dark_mode.png")
                  : Image.asset("assets/images/iris_logo.png"),
              SizedBox(height: 40),
              _getDrawerButton(context, Icons.article_rounded, "Gündem",
                  FeedScreen.routeName),
              _getDrawerButton(context, Icons.language, "Dünya",
                  NewsOfCategoryScreen.routeName, Categories.World),
              _getDrawerButton(context, Icons.money_outlined, "Ekonomi",
                  NewsOfCategoryScreen.routeName, Categories.Economy),
              _getDrawerButton(context, Icons.sports_soccer, "Spor",
                  NewsOfCategoryScreen.routeName, Categories.Sport),
              Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColor.withOpacity(0.5)),
              SizedBox(height: 10),
              _getDrawerButton(context, Icons.bookmark, "Kaydedilen Haberler",
                  SavedNewsScreen.routeName),
              _getDarkModeButton(
                  context,
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  isDarkMode ? "Gündüz Modu" : "Gece Modu"),
              _getDrawerButton(context, Icons.mail_outline, "İris Hakkında",
                  CommunicationScreen.routeName),
            ],
          ),
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
        style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, 30.0),
            alignment: Alignment.topLeft),
        icon: Icon(icons, color: Theme.of(ctx).buttonColor),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(ctx).accentColor,
          ),
        ),
        onPressed: () => Navigator.of(ctx)
            .pushNamed(routeName, arguments: category)
            .then((value) => Navigator.of(context).pop()),
      ),
    );
  }

  Widget _getDarkModeButton(BuildContext ctx, IconData icons, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextButton.icon(
          style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, 30.0),
              alignment: Alignment.topLeft),
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
              Provider.of<ThemesOfApp>(context, listen: false).setMode();
              // isDarkMode = !isDarkMode;
            });
            Navigator.of(ctx).pop();
          }),
    );
  }
}
