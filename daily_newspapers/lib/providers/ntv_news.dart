import 'dart:convert';
import 'dart:developer';
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
    checkBrokenNews();
  }

  @override
  String extractTitle(XmlElement item) {
    try {
      final titleTag =
          item.children.where((child) => child.toString().contains("title"));
      var titleText = titleTag.toString();
      final endPatternIndex = titleText.indexOf("</title>");
      titleText = titleText.replaceRange(endPatternIndex, titleText.length, "");
      titleText = titleText
          .replaceFirst('(<title type="text">', "")
          .replaceAll("&#39;", "'");
      return titleText;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractDescription(XmlElement item) {
    try {
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
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractImageUrl(XmlElement item) {
    try {
      final contentTag =
          item.children.where((child) => child.toString().contains("content"));

      var imageUrl = contentTag.toString();
      final finishPatternIndex = imageUrl.indexOf('" class=');
      final startPatternIndex = imageUrl.indexOf('src="') + 5;
      imageUrl = imageUrl.replaceRange(finishPatternIndex, imageUrl.length, "");
      imageUrl = imageUrl.replaceRange(0, startPatternIndex, "");
      return imageUrl;
    } catch (e) {
      return "broken";
    }
  }

  @override
  String extractNewsUrl(XmlElement item) {
    try {
      var newsUrl = item.toString();
      final startPatternIndex = newsUrl.indexOf("<id>") + 4;
      final endPatternIndex = newsUrl.indexOf("</id>");
      newsUrl = newsUrl.replaceRange(endPatternIndex, newsUrl.length, "");
      newsUrl = newsUrl.replaceRange(0, startPatternIndex, "");
      return newsUrl;
    } catch (e) {
      return "broken";
    }
  }

  @override
  Map<String, String> extractNewsDate(XmlElement item) {
    try {
      final publishedTag = item.children
          .where((child) => child.toString().contains("published"));
      var newsDate = publishedTag.toString();
      final startPatternIndex =
          newsDate.indexOf("(<published>") + "(<published>".length;
      final endPatternIndex = newsDate.indexOf("</published>)");
      newsDate = newsDate.replaceRange(endPatternIndex, newsDate.length, "");
      newsDate = newsDate.replaceRange(0, startPatternIndex, "");
      var splittedDate = newsDate.split("T");
      var newsHour = splittedDate[1];
      newsHour = newsHour.replaceRange(5, newsHour.length, "");
      if (newsHour.length > 5) {
        newsHour = newsHour.replaceRange(6, newsHour.length, "");
      }
      newsDate = splittedDate[0];
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
    news.removeWhere((element) => element.newsDate == "broken");
    news.removeWhere((element) => element.newsHour == "broken");
  }
}
