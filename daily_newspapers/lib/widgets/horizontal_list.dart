import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum NewsPapers { CnnTurk, Ntv, HaberTurk, BBC }

class HorizontalList extends StatelessWidget {
  static const cnnLogoUrl =
      "https://yt3.ggpht.com/ytc/AKedOLS-KBRCkXSVRL6TwhcSIZExe3dbrocmFN2goR0Ceww=s900-c-k-c0x00ffffff-no-rj";
  static const ntvLogoUrl =
      "https://upload.wikimedia.org/wikipedia/commons/b/b5/NTV_logo.png";
  static const haberTurkLogoUrl =
      "https://im.haberturk.com/2016/09/14/ver1473850385/1296680_620x410.jpg";
  static const bbcLogoUrl =
      "https://ichef.bbci.co.uk/news/640/cpsprodpb/C32C/production/_98846994_bbcturkce.png";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: 20),
            buildNewsPaperCell(
                logoUrl: cnnLogoUrl, newsPapers: NewsPapers.CnnTurk),
            SizedBox(width: 20),
            buildNewsPaperCell(logoUrl: ntvLogoUrl, newsPapers: NewsPapers.Ntv),
            SizedBox(width: 20),
            buildNewsPaperCell(
                logoUrl: haberTurkLogoUrl, newsPapers: NewsPapers.HaberTurk),
            SizedBox(width: 20),
            buildNewsPaperCell(logoUrl: bbcLogoUrl, newsPapers: NewsPapers.BBC),
            SizedBox(width: 20),
            Container(
              height: 100,
              width: 100,
              color: Colors.yellow,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  ClipRRect buildNewsPaperCell({String logoUrl, NewsPapers newsPapers}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 100,
        width: 100,
        child: InkWell(
          child: Image.network(logoUrl),
          onTap: () {
            print("Cnn Pressed");
          },
        ),
      ),
    );
  }
}
