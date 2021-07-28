import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  static String routeName = "/loadPage";
  final _url;
  WebScreen(this._url);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _url,
    );
  }
}
