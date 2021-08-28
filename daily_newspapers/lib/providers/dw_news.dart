import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class DWNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://rss.dw.com/rdf/rss-tur-all";
  final _sportNewsUrl = "https://rss.dw.com/xml/rss-tur-eu_spo";
  final _economyNewsUrl = "https://rss.dw.com/xml/rss-tur-eco";
  final _worldNewsUrl = "https://rss.dw.com/xml/rss-tur-pol-tur";

  bool isFeedScreen = true; // since date format different in other categories

  @override
  Future<void> getMainNews() async {
    isFeedScreen = true;
    await sendRequest(_mainNewsUrl);
    notifyListeners();
  }

  @override
  Future<List<NewsModel>> getEconomyNews() async {
    isFeedScreen = false;
    await sendRequest(_economyNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<List<NewsModel>> getWorldNews() async {
    isFeedScreen = false;
    await sendRequest(_worldNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<List<NewsModel>> getSportNews() async {
    isFeedScreen = false;
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
    print(items);
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
    try {
      final titleTag =
          item.children.where((child) => child.toString().contains("<title>"));
      final titleText = titleTag
          .toString()
          .replaceFirst("(<title>", "")
          .replaceFirst("</title>)", "")
          .replaceAll("&quot;", '"')
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
          .where((child) => child.toString().contains("<description>"));
      var descriptionText = descriptionTag.toString();
      descriptionText = descriptionText
          .replaceFirst("(<description>", "")
          .replaceFirst("</description>)", "")
          .replaceAll("&quot;", '"')
          .replaceAll("&#39;", "'");
      return descriptionText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractImageUrl(XmlElement item) {
    try {
      final logoUrl = "https://static.dw.com/image/52015610_101.png";
      return logoUrl;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {
      final linkTag =
          item.children.where((child) => child.toString().contains("<link>"));
      final newsUrlText = linkTag
          .toString()
          .replaceFirst('(<link>', '')
          .replaceFirst('</link>)', '');
      return newsUrlText;
    } catch (e) {
      return "broken";
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

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    try {
      final pubDateTag = item.children
          .where((child) => child.toString().contains("<dc:date>"));
      var newsDate = pubDateTag.toString();
      final startPatternIndex =
          newsDate.indexOf("(<dc:date>") + "(<dc:date>".length;
      final endPatternIndex = newsDate.indexOf("Z</dc:date>)");
      newsDate = newsDate.replaceRange(endPatternIndex, newsDate.length, "");
      newsDate = newsDate.replaceRange(0, startPatternIndex, "");
      final splittedNewsDate = newsDate.split("T");
      var newsHour = splittedNewsDate[1];
      if (newsHour.length > 5) {
        newsHour = newsHour.replaceRange(6, newsHour.length, "");
      }
      newsDate = splittedNewsDate[0];
      Map<String, String> dateAndHour = {
        "date": newsDate,
        "hour": newsHour,
      };
      return dateAndHour;
    } catch (e) {
      return {"date": "broken", "hour": "broken"};
    }
  }
}
