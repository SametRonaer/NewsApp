import 'package:daily_newspapers/providers/bbc_news.dart';
import 'package:daily_newspapers/providers/birgun_news.dart';
import 'package:daily_newspapers/providers/birgun_news.dart';
import 'package:daily_newspapers/providers/cnn_news.dart';
import 'package:daily_newspapers/providers/cnn_news.dart';
import 'package:daily_newspapers/providers/cumhuriyet_news.dart';
import 'package:daily_newspapers/providers/cumhuriyet_news.dart';
import 'package:daily_newspapers/providers/dunya_news.dart';
import 'package:daily_newspapers/providers/dunya_news.dart';
import 'package:daily_newspapers/providers/dw_news.dart';
import 'package:daily_newspapers/providers/dw_news.dart';
import 'package:daily_newspapers/providers/haberturk_news.dart';
import 'package:daily_newspapers/providers/haberturk_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/hurriyet_news.dart';
import 'package:daily_newspapers/providers/milliyet_news.dart';
import 'package:daily_newspapers/providers/milliyet_news.dart';
import 'package:daily_newspapers/providers/ntv_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';
import 'package:daily_newspapers/providers/sabah_news.dart';
import 'package:daily_newspapers/providers/star_news.dart';
import 'package:daily_newspapers/providers/star_news.dart';
import 'package:daily_newspapers/providers/t24_news.dart';
import 'package:daily_newspapers/providers/t24_news.dart';
import 'package:daily_newspapers/providers/takvim_news.dart';
import 'package:daily_newspapers/providers/takvim_news.dart';
import 'package:daily_newspapers/providers/tgrt_news.dart';
import 'package:daily_newspapers/providers/tgrt_news.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Ntv RSS check", () async {
    NtvNews ntvNews = NtvNews();
    await ntvNews.getMainNews();
    int newsCount = ntvNews.news.length;
    expect(newsCount > 0, true);
  });

  test("BBC RSS check", () async {
    BBCNews bbcNews = BBCNews();
    await bbcNews.getMainNews();
    int newsCount = bbcNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Birgun RSS check", () async {
    BirgunNews birgunNews = BirgunNews();
    await birgunNews.getMainNews();
    int newsCount = birgunNews.news.length;
    expect(newsCount > 0, true);
  });

  test("CNN RSS check", () async {
    CnnNews cnnNews = CnnNews();
    await cnnNews.getMainNews();
    int newsCount = cnnNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Cumhuriyet RSS check", () async {
    CumhuriyetNews cumhuriyetNews = CumhuriyetNews();
    await cumhuriyetNews.getMainNews();
    int newsCount = cumhuriyetNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Dunya RSS check", () async {
    DunyaNews dunyaNews = DunyaNews();
    await dunyaNews.getMainNews();
    int newsCount = dunyaNews.news.length;
    expect(newsCount > 0, true);
  });

  test("DW RSS check", () async {
    DWNews dwNews = DWNews();
    await dwNews.getMainNews();
    int newsCount = dwNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Haberturk RSS check", () async {
    HaberturkNews haberturkNews = HaberturkNews();
    await haberturkNews.getMainNews();
    int newsCount = haberturkNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Hurriyet RSS check", () async {
    HurriyetNews hurriyetNews = HurriyetNews();
    await hurriyetNews.getMainNews();
    int newsCount = hurriyetNews.news.length;
    expect(newsCount > 0, true);
  });

  // test("Milliyet RSS check", () async {
  //   MilliyetNews milliyetNews = MilliyetNews();
  //   await milliyetNews.getMainNews();
  //   int newsCount = milliyetNews.news.length;
  //   expect(newsCount > 0, true);
  // });

  test("Sabah RSS check", () async {
    SabahNews sabahNews = SabahNews();
    await sabahNews.getMainNews();
    int newsCount = sabahNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Star RSS check", () async {
    StarNews starNews = StarNews();
    await starNews.getMainNews();
    int newsCount = starNews.news.length;
    expect(newsCount > 0, true);
  });

  test("T24 RSS check", () async {
    T24News t24News = T24News();
    await t24News.getMainNews();
    int newsCount = t24News.news.length;
    expect(newsCount > 0, true);
  });

  test("Takvim RSS check", () async {
    TakvimNews takvimNews = TakvimNews();
    await takvimNews.getMainNews();
    int newsCount = takvimNews.news.length;
    expect(newsCount > 0, true);
  });

  test("Tgrt RSS check", () async {
    TGRTNews tgrtNews = TGRTNews();
    await tgrtNews.getMainNews();
    int newsCount = tgrtNews.news.length;
    expect(newsCount > 0, true);
  });
}
