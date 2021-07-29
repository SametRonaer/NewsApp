import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum NewsPapers { CnnNews, NtvNews, HaberturkNews, BBCNews }

class HorizontalListOfNewsPapers extends StatefulWidget {
  static const cnnLogoUrl =
      "https://yt3.ggpht.com/ytc/AKedOLS-KBRCkXSVRL6TwhcSIZExe3dbrocmFN2goR0Ceww=s900-c-k-c0x00ffffff-no-rj";
  static const ntvLogoUrl =
      "https://upload.wikimedia.org/wikipedia/commons/b/b5/NTV_logo.png";
  static const haberTurkLogoUrl =
      "https://im.haberturk.com/2016/09/14/ver1473850385/1296680_620x410.jpg";
  static const bbcLogoUrl =
      "https://ichef.bbci.co.uk/news/640/cpsprodpb/C32C/production/_98846994_bbcturkce.png";

  final Function _switchNewsPaper;

  HorizontalListOfNewsPapers(this._switchNewsPaper);

  @override
  _HorizontalListOfNewsPapersState createState() =>
      _HorizontalListOfNewsPapersState();
}

class _HorizontalListOfNewsPapersState
    extends State<HorizontalListOfNewsPapers> {
  NewsPapers _selectedNewsPaper = NewsPapers.CnnNews;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 130,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              buildNewsPaperCell(
                  logoUrl: HorizontalListOfNewsPapers.cnnLogoUrl,
                  newsPapers: NewsPapers.CnnNews),
              SizedBox(width: 20),
              buildNewsPaperCell(
                  logoUrl: HorizontalListOfNewsPapers.ntvLogoUrl,
                  newsPapers: NewsPapers.NtvNews),
              SizedBox(width: 20),
              buildNewsPaperCell(
                  logoUrl: HorizontalListOfNewsPapers.haberTurkLogoUrl,
                  newsPapers: NewsPapers.HaberturkNews),
              SizedBox(width: 20),
              buildNewsPaperCell(
                  logoUrl: HorizontalListOfNewsPapers.bbcLogoUrl,
                  newsPapers: NewsPapers.BBCNews),
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
      ),
    );
  }

  Widget markCurrentNewsPaper() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
    );
  }

  Widget buildNewsPaperCell({String logoUrl, NewsPapers newsPapers}) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 100,
            width: 100,
            child: InkWell(
              child: Image.network(logoUrl),
              onTap: () {
                widget._switchNewsPaper(newsPapers);
                setState(() {
                  _selectedNewsPaper = newsPapers;
                });
              },
            ),
          ),
        ),
        if (_selectedNewsPaper == newsPapers) markCurrentNewsPaper()
      ],
    );
  }
}
