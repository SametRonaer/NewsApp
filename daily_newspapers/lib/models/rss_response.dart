import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

import 'news.dart';

abstract class RssResponse extends ChangeNotifier {
  Future<void> getMainNews();
  Future getEconomyNews();
  Future getWorldNews();
  Future getSportNews();
  Future sendRequest(String url);
  void putNews(List<XmlElement> items);
  String extractTitle(XmlElement item);
  String extractDescription(XmlElement item);
  String extractImageUrl(XmlElement item);
  String extractNewsUrl(XmlElement item);
  Map<String, String> extractNewsDate(XmlElement item);
}
