import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

import 'news.dart';

abstract class RssResponse extends ChangeNotifier {
  void getMainNews();
  Future<void> sendRequest();
  void putNews(List<XmlElement> items);
  String extractTitle(XmlElement item);
  String extractDescription(XmlElement item);
  String extractImageUrl(XmlElement item);
  String extractNewsUrl(XmlElement item);
}
