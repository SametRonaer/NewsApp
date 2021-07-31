import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class NtvNews extends RssResponse {
  List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.ntv.com.tr/son-dakika.rss";
  final _sportNewsUrl = "https://www.ntv.com.tr/spor.rss";
  final _economyNewsUrl = "https://www.ntv.com.tr/ekonomi.rss";
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
    var items = document.findAllElements("entry").toList();
    putNews(items);

    // log(items.toList()[0].toString());
    extractTitle(items[2]);
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
    var titleText = titleTag.toString();
    final endPatternIndex = titleText.indexOf("</title>");
    titleText = titleText.replaceRange(endPatternIndex, titleText.length, "");
    titleText = titleText
        .replaceFirst('(<title type="text">', "")
        .replaceAll("&#39;", "'");
    return titleText;
  }

  @override
  String extractDescription(XmlElement item) {
    final contentTag =
        item.children.where((child) => child.toString().contains("content"));
    var descriptionText = contentTag.toString();
    final startPatternIndex = descriptionText.indexOf('alt="') + 5;
    descriptionText = descriptionText
        .replaceRange(0, startPatternIndex, "")
        .replaceAll("</p>", "")
        .replaceAll("<p>", "")
        .replaceAll("<br>", "")
        .replaceAll("<strong>", "")
        .replaceAll("</strong>", "")
        .replaceAll("/>", "");
    descriptionText =
        descriptionText.replaceRange(150, descriptionText.length, "...");
    if (descriptionText.contains("<a href")) {
      final endPatternIndex = descriptionText.indexOf("<a href");
      descriptionText = descriptionText.replaceRange(
          endPatternIndex, descriptionText.length, "");
    }
    if (descriptionText.contains("<img")) {
      final endPatternIndex = descriptionText.indexOf("<img");
      descriptionText = descriptionText.replaceRange(
          endPatternIndex, descriptionText.length, "");
    }
    return descriptionText;
  }

  @override
  String extractImageUrl(XmlElement item) {
    final contentTag =
        item.children.where((child) => child.toString().contains("content"));

    var imageUrl = contentTag.toString();
    final finishPatternIndex = imageUrl.indexOf('" class=');
    final startPatternIndex = imageUrl.indexOf('src="') + 5;
    imageUrl = imageUrl.replaceRange(finishPatternIndex, imageUrl.length, "");
    imageUrl = imageUrl.replaceRange(0, startPatternIndex, "");
    return imageUrl;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    var newsUrl = item.toString();
    final startPatternIndex = newsUrl.indexOf("<id>") + 4;
    final endPatternIndex = newsUrl.indexOf("</id>");
    newsUrl = newsUrl.replaceRange(endPatternIndex, newsUrl.length, "");
    newsUrl = newsUrl.replaceRange(0, startPatternIndex, "");
    return newsUrl;
  }
}
