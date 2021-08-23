import 'dart:convert';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class SabahNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.sabah.com.tr/rss/gundem.xml";
  final _sportNewsUrl = "https://www.sabah.com.tr/rss/spor.xml";
  final _economyNewsUrl = "https://www.sabah.com.tr/rss/ekonomi.xml";
  final _worldNewsUrl = "https://www.sabah.com.tr/rss/dunya.xml";
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
      var firstIndex = descriptionText.indexOf('alt="');
      final endIndex = descriptionText.indexOf("<a href");
      descriptionText =
          descriptionText.replaceRange(endIndex, descriptionText.length, "");
      descriptionText = descriptionText.replaceRange(0, firstIndex, "");
      descriptionText = descriptionText
          .replaceFirst("alt=", "")
          .replaceFirst("/><br />", "")
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
      final imageTag = item.children
          .where((child) => child.toString().contains("<enclosure"));
      var imageUrlText = imageTag.toString();
      final endIndex = imageUrlText.indexOf('" length="50000"');
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
      final newsUrlText = linkTag
          .toString()
          .replaceFirst('(<link>', '')
          .replaceFirst('</link>)', '');
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
}
