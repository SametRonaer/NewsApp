import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:xml/xml.dart';
import "dart:core";
import '../constants/rss_urls.dart';

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
        onPressed: fetchNews,
      ),
    );
  }

  void fetchNews() async {
    var reponse = await get(Uri.parse(RssUrls.bbcNews));
    var decodedResponse = utf8.decode(reponse.bodyBytes);
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

      //  CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN CNN
      // image
      // sElement = sElement.replaceFirst("<image>", "");
      // sElement = sElement.replaceFirst("</image>", "");

      // print("***********************************");
    });
    //print(titles);
  }
}
