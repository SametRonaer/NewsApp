import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class CnnNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.cnnturk.com/feed/rss/turkiye/news";
  final _sportNewsUrl = "https://www.cnnturk.com/feed/rss/spor/";
  final _economyNewsUrl = "https://www.cnnturk.com/feed/rss/ekonomi/";
  final _worldNewsUrl = "https://www.cnnturk.com/feed/rss/dunya/news";
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
    final titleTag =
        item.children.where((child) => child.toString().contains("title"));
    final titleText = titleTag
        .toString()
        .replaceFirst("(<title><![CDATA[", "")
        .replaceFirst("]]></title>)", "")
        .replaceAll("&quot;", '"')
        .replaceAll("&#39;", "'");

    return titleText;
  }

  @override
  String extractDescription(XmlElement item) {
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
    final imageTag =
        item.children.where((child) => child.toString().contains("image"));
    final imageUrlText = imageTag
        .toString()
        .replaceFirst("(<image>", "")
        .replaceFirst("</image>)", "");
    return imageUrlText;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    final linkTag =
        item.children.where((child) => child.toString().contains("atom:link"));
    final newsUrlText = linkTag
        .toString()
        .replaceFirst('(<atom:link href="', '')
        .replaceFirst('"/>)', '');
    return newsUrlText;
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
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
    newsDate = newsDate.replaceRange(splittingPointIndex, newsDate.length, "");
    Map<String, String> dateAndHour = {
      "date": newsDate,
      "hour": newsHour,
    };
    return dateAndHour;
  }
}
