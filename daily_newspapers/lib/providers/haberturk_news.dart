import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:xml/xml.dart';

class HaberturkNews extends RssResponse {
  final List<NewsModel> news = [];
  final _mainNewsUrl = "https://www.haberturk.com/rss/manset.xml";
  final _sportNewsUrl = "https://www.haberturk.com/rss/spor.xml";
  final _economyNewsUrl = "https://www.haberturk.com/rss/ekonomi.xml";
  final _worldNewsUrl = "https://www.ntv.com.tr/dunya.rss";
  @override
  Future<void> getMainNews() async {
    await sendRequest(_mainNewsUrl);
    notifyListeners();
  }

  @override
  Future<List<NewsModel>> getEconomyNews() async {
    await sendRequest(_economyNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<List<NewsModel>> getWorldNews() async {
    await sendRequest(_worldNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<List<NewsModel>> getSportNews() async {
    await sendRequest(_sportNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<void> sendRequest(String newsUrl) async {
    final url = Uri.parse(newsUrl);
    var response = await http.get(url);
    var decodedResponse = utf8.decode(response.bodyBytes);
    var document = XmlDocument.parse(decodedResponse);
    var items = document.findAllElements("item").toList();
    putNews(items);
  }

  @override
  void putNews(List<XmlElement> items) {
    news.clear();
    items.map(
      (item) {
        news.add(NewsModel(
          id: DateTime.now().toString(),
          title: extractTitle(item),
          description: extractDescription(item),
          imageUrl: extractImageUrl(item),
          newsUrl: extractNewsUrl(item),
          newsDate: extractNewsDate(item)['date'],
          newsHour: extractNewsDate(item)['hour'],
        ));
      },
    ).toList();
  }

  @override
  String extractTitle(XmlElement item) {
    try {
      final titleTag =
          item.children.where((child) => child.toString().contains("title"));
      final titleText = titleTag
          .toString()
          .replaceFirst("(<title>", "")
          .replaceFirst("</title>)", "")
          .replaceAll("<![CDATA[", "")
          .replaceAll("]]>", "")
          .replaceAll("&#39;", "'");
      return titleText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractDescription(XmlElement item) {
    try {
      final descriptionTag = item.children
          .where((child) => child.toString().contains("description"));
      var descriptionText = descriptionTag.toString();
      final startPatternIndex = descriptionText.indexOf("alt='") + 5;
      final endPatternIndex = descriptionText.indexOf("' align='left'");
      descriptionText = descriptionText.replaceRange(
          endPatternIndex, descriptionText.length, "");
      descriptionText = descriptionText.replaceRange(0, startPatternIndex, "");
      return descriptionText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractImageUrl(XmlElement item) {
    try {
      final imageTag =
          item.children.where((child) => child.toString().contains("image"));
      var imageUrlText = imageTag.toString();
      final endPatternIndex = imageUrlText.indexOf("</image>");
      imageUrlText = imageUrlText
          .replaceRange(endPatternIndex, imageUrlText.length, "")
          .replaceFirst("(<image>", "")
          .replaceAll("<![CDATA[", "")
          .replaceAll("]]>", "");
      return imageUrlText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {
      final linkTag =
          item.children.where((child) => child.toString().contains("link"));
      final newsUrlText = linkTag
          .toString()
          .replaceFirst('(<link>', '')
          .replaceFirst('</link>)', '')
          .replaceAll("<![CDATA[", "")
          .replaceAll("]]>", "");
      return newsUrlText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    try {
      final pubDateTag =
          item.children.where((child) => child.toString().contains("pubDate"));
      var newsDate = pubDateTag.toString();
      final startPatternIndex =
          newsDate.indexOf("(<pubDate><![CDATA[") + "(<pubDate>".length;
      final endPatternIndex = newsDate.indexOf("GMT]]></pubDate>)");
      newsDate = newsDate.replaceRange(endPatternIndex, newsDate.length, "");
      newsDate = newsDate.replaceRange(0, startPatternIndex, "");
      newsDate = newsDate.split(",")[1];
      final splittingPointIndex = newsDate.indexOf("202") + 4;
      var newsHour = newsDate.replaceRange(0, splittingPointIndex, "");
      if (newsHour.length > 5) {
        newsHour = newsHour.replaceRange(6, newsHour.length, "");
      }
      newsDate =
          newsDate.replaceRange(splittingPointIndex, newsDate.length, "");
      Map<String, String> dateAndHour = {
        "date": newsDate,
        "hour": newsHour,
      };
      return dateAndHour;
    } catch (e) {
      return {"date": "broken", "hour": "broken"};
    }
  }
  @override
  void checkBrokenNews() {
    news.removeWhere((element) => element.title == "broken");
    news.removeWhere((element) => element.description == "broken");
    news.removeWhere((element) => element.imageUrl == "broken");
    news.removeWhere((element) => element.newsUrl == "broken");
    news.removeWhere((element) => element.newsDate == "broken");
    news.removeWhere((element) => element.newsHour == "broken");
  }
}
