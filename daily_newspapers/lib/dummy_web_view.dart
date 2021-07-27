import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DummyWebView extends StatefulWidget {
  @override
  _DummyWebViewState createState() => _DummyWebViewState();
}

class _DummyWebViewState extends State<DummyWebView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://flutter.dev',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("pressed");
        },
      ),
    );
  }
}
