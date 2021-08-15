import 'package:daily_newspapers/models/news.dart';
import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';
class ShareNewsWithOtherApps{
  static Future<void> shareNews(String newsUrl) async{
    await SocialShare.shareOptions(newsUrl);
  }
}