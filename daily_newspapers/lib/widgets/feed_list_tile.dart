import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedListTile extends StatelessWidget {
  final String newsTitle;
  final String newsDescription;
  final String newsImageUrl;
  final String newsUrl;

  FeedListTile(
      {this.newsTitle, this.newsDescription, this.newsImageUrl, this.newsUrl});

  void launchThere(String url) async {
    await canLaunch(url)
        ? await launch(
            url,
            enableJavaScript: true,
            forceWebView: true,
            headers: <String, String>{'my_header_key': 'my_header_value'},
          )
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        try {
          //launchThere(newsUrl);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoadWebPage(newsUrl),
            ),
          );
        } catch (e) {
          print(e);
          print("ERROR");
        }
        print("Tapped");
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

class LoadWebPage extends StatelessWidget {
  static String routeName = "/loadPage";
  final _url;
  LoadWebPage(this._url);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _url,
    );
  }
}
