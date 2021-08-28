import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class MilliyetNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.milliyet.com.tr/rss/rssNew/gundemRss.xml";
  final _sportNewsUrl = "";
  final _economyNewsUrl =
      "https://www.milliyet.com.tr/rss/rssNew/ekonomiRss.xml";
  final _worldNewsUrl = "https://www.milliyet.com.tr/rss/rssNew/dunyaRss.xml";
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
        ));
      },
    ).toList();
    _checkBrokenNews();
  }

  @override
  String extractTitle(XmlElement item) {
    try {
      final titleTag =
          item.children.where((child) => child.toString().contains("<title>"));
      final titleText = titleTag
          .toString()
          .replaceFirst("(<title><![CDATA[", "")
          .replaceFirst("]]></title>)", "")
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
      final firstIndex = descriptionText.indexOf("<p>");
      descriptionText = descriptionText.replaceRange(0, firstIndex, "");
      descriptionText = descriptionText
          .replaceFirst("<p><strong>", "")
          .replaceFirst("</p>", "")
          .replaceFirst("]]></description>)", "")
          .replaceAll("&quot;", '"')
          .replaceAll("&#39;", "'");
      print(descriptionText);
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
      final imageUrlText = imageTag
          .toString()
          .replaceFirst("(<image>", "")
          .replaceFirst("</image>)", "");
      return imageUrlText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {
      final linkTag = item.children
          .where((child) => child.toString().contains("atom:link"));
      final newsUrlText = linkTag
          .toString()
          .replaceFirst('(<atom:link href="', '')
          .replaceFirst('"/>)', '');
      return newsUrlText;
    } catch (e) {
      return "broken";
    }
  }

  void _checkBrokenNews() {
    news.removeWhere((element) => element.title == "broken");
    news.removeWhere((element) => element.description == "broken");
    news.removeWhere((element) => element.imageUrl == "broken");
    news.removeWhere((element) => element.newsUrl == "broken");
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    return null;
  }
}
