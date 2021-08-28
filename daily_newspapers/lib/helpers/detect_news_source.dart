import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/models/news.dart';

class DetectNewsSource {
  static String newsPaperLogoUrl = "";

  static String getNewsSource(NewsModel news) {
    if (news.newsUrl.contains("cnnturk")) {
      _getNewspaperLogoUrl("CnnNews");
      return "CnnTürk";
    } else if (news.newsUrl.contains("ntv")) {
      _getNewspaperLogoUrl("NtvNews");
      return "Ntv";
    } else if (news.newsUrl.contains("sabah")) {
      _getNewspaperLogoUrl("SabahNews");
      return "Sabah";
    } else if (news.newsUrl.contains("takvim")) {
      _getNewspaperLogoUrl("TakvimNews");
      return "Takvim";
    } else if (news.newsUrl.contains("haberturk")) {
      _getNewspaperLogoUrl("HaberturkNews");
      return "Habertürk";
    } else if (news.newsUrl.contains("hurriyet")) {
      _getNewspaperLogoUrl("HurriyetNews");
      return "Hürriyet";
    } else if (news.newsUrl.contains("star")) {
      _getNewspaperLogoUrl("StarNews");
      return "Star";
    } else if (news.newsUrl.contains("tgrt")) {
      _getNewspaperLogoUrl("TGRTNews");
      return "TGRT";
    } else if (news.newsUrl.contains("dw")) {
      _getNewspaperLogoUrl("DWNews");
      return "Deutsche Welle";
    } else if (news.newsUrl.contains("bbc")) {
      _getNewspaperLogoUrl("BBCNews");
      return "BBC";
    } else if (news.newsUrl.contains("birgun")) {
      _getNewspaperLogoUrl("BirgunNews");
      return "Birgün";
    } else if (news.newsUrl.contains("cumhuriyet")) {
      _getNewspaperLogoUrl("CumhuriyetNews");
      return "Cumhuriyet";
    } else if (news.newsUrl.contains("dunya")) {
      _getNewspaperLogoUrl("DunyaNews");
      return "Dünya Gazetesi";
      // } else if (news.newsUrl.contains("milliyet")) {
      //   return "Milliyet";
      // } else if (news.newsUrl.contains("t24")) {
      //   return "T24";
      // } else {
      return "";
    }
  }

  static void _getNewspaperLogoUrl(String newspaper) {
    NewsPapers.allNewsPapersWithUrl.forEach((element) {
      if (element['title'].contains(newspaper)) {
        newsPaperLogoUrl = element['imageUrl'];
      }
    });
  }
}
