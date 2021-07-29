import 'package:daily_newspapers/screens/saved_news_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: Drawer(
        child: Column(
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
            SizedBox(height: 40),
            TextButton.icon(
              icon: Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                "Saved News",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SavedNewsScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
