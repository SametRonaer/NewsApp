import 'dart:convert';
import 'dart:developer';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class BirgunNews extends RssResponse {
  final List<NewsModel> news = [];

  final _mainNewsUrl = "https://www.birgun.net/xml/rss.xml";
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
        .replaceFirst("(<title>", "")
        .replaceFirst("</title>)", "")
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
        .replaceFirst("(<description>", "")
        .replaceFirst("</description>)", "")
        .replaceAll("&quot;", '"')
        .replaceAll("&#39;", "'");
    return descriptionText;
  }

  @override
  String extractImageUrl(XmlElement item) {
    final imageUrlText =
        "https://static.birgun.net/resim/haber-detay-resim/2019/12/12/to-our-readers-660744-5.jpg";
    return imageUrlText;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    final linkTag =
        item.children.where((child) => child.toString().contains("<link>"));
    var newsUrlText = linkTag.toString();
    newsUrlText =
        newsUrlText.replaceFirst('(<link>', '').replaceFirst('</link>)', '');
    return newsUrlText;
  }
}
