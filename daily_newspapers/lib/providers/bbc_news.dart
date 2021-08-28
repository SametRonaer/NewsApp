import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class BBCNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://feeds.bbci.co.uk/turkce/rss.xml";
  final _worldNewsUrl = "https://feeds.bbci.co.uk/turkce/rss.xml";
  @override
  Future<void> getMainNews() async {
    await sendRequest(_mainNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<void> getEconomyNews() async {
    news.clear();
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
  Future<void> getSportNews() async {
    news.clear();
    notifyListeners();
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
          newsDate: extractNewsDate(item)["date"],
          newsHour: extractNewsDate(item)["hour"],
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
        .replaceAll("&#39;", "'");
    return descriptionText;
  }

  @override
  String extractImageUrl(XmlElement _) {
    // There are no images in RSS response that's why i used bbc logo for all bbc news
    final bbcLogo =
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/D912/production/_104507555_bbc_turkce_logo-nc.png";
    return bbcLogo;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    final linkTag =
        item.children.where((child) => child.toString().contains("<link>"));
    final newsUrlText = linkTag
        .toString()
        .replaceFirst('(<link>', '')
        .replaceFirst('</link>)', '');
    return newsUrlText;
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    final pubDateTag =
        item.children.where((child) => child.toString().contains("pubDate"));
    var newsDate = pubDateTag.toString();
    // print(newsDate);
    final startPatternIndex =
        newsDate.indexOf("(<pubDate>") + "(<pubDate>".length;
    final endPatternIndex = newsDate.indexOf("GMT</pubDate>)");
    newsDate = newsDate.replaceRange(endPatternIndex, newsDate.length, "");
    newsDate = newsDate.replaceRange(0, startPatternIndex, "");
    newsDate = newsDate.split(",")[1];
    final splittingPointIndex = newsDate.indexOf("202") + 4;
    var newsHour = newsDate.replaceRange(0, splittingPointIndex, "");
    newsDate = newsDate.replaceRange(splittingPointIndex, newsDate.length, "");
    // print(newsHour);
    // print(newsDate);
    Map<String, String> dateAndHour = {
      "date": newsDate,
      "hour": newsHour,
    };
    return dateAndHour;
  }
}
