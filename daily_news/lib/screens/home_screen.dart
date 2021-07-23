import 'dart:convert';
import 'dart:developer';

import 'package:daily_news/providers/bbc_news.dart';
import 'package:daily_news/providers/cnn_news.dart';
import 'package:daily_news/providers/haberturkNews.dart';
import 'package:daily_news/providers/ntv_news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:xml/xml.dart';
import "dart:core";
import '../constants/rss_urls.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home Screen"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: apiCheck,
      ),
    );
  }

  Future<void> apiCheck() async {
    var responseString =
        await Provider.of<HaberturkNews>(context, listen: false).sendRequest();
    // print(responseString);
  }

  void fetchNews() async {
    var response = await get(Uri.parse(RssUrls.bbcNews));
    var decodedResponse = utf8.decode(response.bodyBytes);
    // try {
    //   var channel = RssFeed.parse(decodedResponse);
    //   log(channel.toString());
    // } catch (e) {
    //   print(e);
    // }

    //log(decodedResponse);
    final document = XmlDocument.parse(decodedResponse);
    //log(document.toString());
    var titles = document.findAllElements("title");

    titles.forEach((element) {
      //print(element);

      // print("..............................");
      var sElement = element.toString();

      // BBC BBC BBC BBC BBC BBC BBC BBC BBC BBC BBC BBC BBC
      if (!sElement.contains("BBC")) {
        log(sElement);
      }

      //print(sElement);

      // HABERTURK HABERTURK HABERTURK HABERTURK HABERTURK HABERTURK
      // image
      // ilk elemanini alma cunku haber degil

      // sElement = sElement.replaceFirst("<image>", "");
      // sElement = sElement.replaceFirst("</image>", "");
      // print(sElement);

      //   NTV  NTV  NTV  NTV  NTV  NTV  NTV  NTV  NTV  NTV  NTV
      // content

      // sElement =
      //     sElement.replaceFirst('<content type="html"><![CDATA[<img src="', "");
      // int startPoint = sElement.indexOf('"');
      // int endPoint = sElement.length;
      // sElement = sElement.replaceRange(startPoint, endPoint, "");
    });
    //print(titles);
  }
}
