import 'dart:convert';
import 'dart:developer';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class DunyaNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.dunya.com/rss";
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
    try {
      final titleTag =
          item.children.where((child) => child.toString().contains("title"));
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
          .where((child) => child.toString().contains("description"));
      var descriptionText = descriptionTag.toString();
      final firstIndex = descriptionText.indexOf("<![CDATA[");
      descriptionText = descriptionText.replaceRange(1, firstIndex, "");
      descriptionText = descriptionText
          .replaceFirst("(<![CDATA[", "")
          .replaceFirst("]]></description>)", "")
          .replaceAll("&quot;", '"')
          .replaceAll("&#039;", "'")
          .replaceAll("&#39;", "'");
      return descriptionText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractImageUrl(XmlElement item) {
    try {
      final imageTag = item.children
          .where((child) => child.toString().contains("enclosure"));
      var imageUrlText = imageTag.toString();
      final endIndex = imageUrlText.indexOf('" length');
      imageUrlText =
          imageUrlText.replaceRange(endIndex, imageUrlText.length, "");
      imageUrlText = imageUrlText.replaceFirst('(<enclosure url="', "");
      return imageUrlText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {
      final linkTag =
          item.children.where((child) => child.toString().contains("<link>"));
      var newsUrlText = linkTag.toString();
      newsUrlText =
          newsUrlText.replaceFirst('(<link>', '').replaceFirst('</link>)', '');
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
          newsDate.indexOf("(<pubDate>") + "(<pubDate>".length;
      final endPatternIndex = newsDate.indexOf("+0300</pubDate>)");
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
  }
}
