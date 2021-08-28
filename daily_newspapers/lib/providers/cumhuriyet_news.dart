import 'dart:convert';
import 'dart:developer';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class CumhuriyetNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.cumhuriyet.com.tr/rss/son_dakika.xml";
  final _sportNewsUrl = "";
  final _economyNewsUrl = "";
  final _worldNewsUrl = "";
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
    checkBrokenNews();
  }

  @override
  String extractTitle(XmlElement item) {
    try {} catch (e) {
      return "broken";
    }
    final titleTag =
        item.children.where((child) => child.toString().contains("title"));
    final titleText = titleTag
        .toString()
        .replaceFirst("(<title>", "")
        .replaceFirst("</title>)", "")
        .replaceAll("&quot;", '"')
        .replaceAll("&#39;", "'");
    return titleText;
  }

  @override
  String extractDescription(XmlElement item) {
    try {} catch (e) {
      return "broken";
    }
    final descriptionTag = item.children
        .where((child) => child.toString().contains("description"));
    final descriptionText = descriptionTag
        .toString()
        .replaceFirst("(<description><![CDATA[", "")
        .replaceFirst("]]></description>)", "")
        .replaceAll("&quot;", '"')
        .replaceAll("&#39;", "'");
    return descriptionText;
  }

  @override
  String extractImageUrl(XmlElement item) {
    try {} catch (e) {
      return "broken";
    }
    final imageTag =
        item.children.where((child) => child.toString().contains("thumbnail"));
    final imageUrlText = imageTag
        .toString()
        .replaceFirst('(<thumbnail url="', "")
        .replaceFirst('" type="image/jpeg"/>)', "");
    return imageUrlText;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {} catch (e) {
      return "broken";
    }
    final linkTag =
        item.children.where((child) => child.toString().contains("<link>"));
    var newsUrlText = linkTag.toString();

    newsUrlText =
        newsUrlText.replaceFirst('(<link>', '').replaceFirst('</link>)', '');
    return newsUrlText;
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    try {
      final pubDateTag =
          item.children.where((child) => child.toString().contains("pubDate"));
      var newsDate = pubDateTag.toString();
      final startPatternIndex =
          newsDate.indexOf("(<pubDate>") + "(<pubDate>".length;
      final endPatternIndex = newsDate.indexOf("GMT</pubDate>)");
      newsDate = newsDate.replaceRange(endPatternIndex, newsDate.length, "");
      newsDate = newsDate.replaceRange(0, startPatternIndex, "");
      newsDate = newsDate.split(",")[1];
      final splittingPointIndex = newsDate.indexOf("202") + 4;
      var newsHour = newsDate.replaceRange(0, splittingPointIndex, "");
      newsDate =
          newsDate.replaceRange(splittingPointIndex, newsDate.length, "");
      if (newsHour.length > 5) {
        newsHour = newsHour.replaceRange(6, newsHour.length, "");
      }
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
  }
}
