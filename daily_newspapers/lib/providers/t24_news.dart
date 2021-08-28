import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class T24News extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://t24.com.tr/rss";
  final _economyNewsUrl = "https://t24.com.tr/rss/haber/ekonomi";
  final _sportNewsUrl = "https://t24.com.tr/rss/haber/spor";
  final _cinemaNewsUrl = "https://t24.com.tr/rss/haber/kultur-sanat";
  final _technologyNews = "https://t24.com.tr/rss/haber/bilim-teknoloji";
  final _worldNewsUrl = "https://t24.com.tr/rss/haber/dunya-basininda-bugun";
  @override
  Future<void> getMainNews() async {
    await sendRequest(_mainNewsUrl);
    notifyListeners();
    return news;
  }

  @override
  Future<void> getEconomyNews() async {
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
  Future<void> getSportNews() async {
    await sendRequest(_sportNewsUrl);
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
  String extractImageUrl(XmlElement item) {
    // There are no images in RSS response that's why i used bbc logo for all bbc news
    // final imageTag = item.children
    //     .where((child) => child.toString().contains("<enclosure>"));
    // var imageUrlText = imageTag.toString();
    final logoUrl = "https://t24.com.tr/share/twitter.jpg";
    return logoUrl;
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
    return null;
  }
}
