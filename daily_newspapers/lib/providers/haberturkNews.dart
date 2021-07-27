import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/rss_urls.dart';
import '../models/news.dart';
import '../models/rss_response.dart';
import 'package:xml/xml.dart';

class HaberturkNews extends RssResponse {
  final List<NewsModel> news = [];

  @override
  Future<void> getMainNews() async {
    await sendRequest();
    notifyListeners();
  }

  @override
  Future<void> sendRequest() async {
    final url = Uri.parse(RssUrls.haberturkNews);
    var response = await http.get(url);
    var decodedResponse = utf8.decode(response.bodyBytes);
    var document = XmlDocument.parse(decodedResponse);
    var items = document.findAllElements("item").toList();
    putNews(items);
  }

  @override
  void putNews(List<XmlElement> items) {
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
        .replaceAll("&#39;", "'");
    return titleText;
  }

  @override
  String extractDescription(XmlElement item) {
    final descriptionTag = item.children
        .where((child) => child.toString().contains("description"));
    var descriptionText = descriptionTag.toString();
    final startPatternIndex = descriptionText.indexOf("alt='") + 5;
    final endPatternIndex = descriptionText.indexOf("' align='left'");
    descriptionText = descriptionText.replaceRange(
        endPatternIndex, descriptionText.length, "");
    descriptionText = descriptionText.replaceRange(0, startPatternIndex, "");
    return descriptionText;
  }

  @override
  String extractImageUrl(XmlElement item) {
    final imageTag =
        item.children.where((child) => child.toString().contains("image"));
    var imageUrlText = imageTag.toString();
    final endPatternIndex = imageUrlText.indexOf("</image>");
    imageUrlText = imageUrlText
        .replaceRange(endPatternIndex, imageUrlText.length, "")
        .replaceFirst("(<image>", "");
    return imageUrlText;
  }

  @override
  String extractNewsUrl(XmlElement item) {
    final linkTag =
        item.children.where((child) => child.toString().contains("link"));
    final newsUrlText = linkTag
        .toString()
        .replaceFirst('(<link>', '')
        .replaceFirst('</link>)', '');
    return newsUrlText;
  }
}
