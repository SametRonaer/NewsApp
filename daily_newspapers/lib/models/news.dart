import 'package:flutter/foundation.dart';

class NewsModel {
  String id;
  String title;
  String description;
  String imageUrl;
  String newsUrl;
  String newsDate;
  String newsHour;

  NewsModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.newsUrl,
    @required this.newsDate,
    @required this.newsHour,
  });
}
