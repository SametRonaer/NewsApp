// import 'package:daily_newspapers/helpers/db_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//

//
// class HorizontalListOfNewsPapers extends StatefulWidget {
//   String cnnLogoUrl =
//       "https://yt3.ggpht.com/ytc/AKedOLS-KBRCkXSVRL6TwhcSIZExe3dbrocmFN2goR0Ceww=s900-c-k-c0x00ffffff-no-rj";
//   static const ntvLogoUrl =
//       "https://upload.wikimedia.org/wikipedia/commons/b/b5/NTV_logo.png";
//   static const haberTurkLogoUrl =
//       "https://im.haberturk.com/2016/09/14/ver1473850385/1296680_620x410.jpg";
//   static const bbcLogoUrl =
//       "https://ichef.bbci.co.uk/news/640/cpsprodpb/C32C/production/_98846994_bbcturkce.png";
//
//   final Function _switchNewsPaper;
//
//   HorizontalListOfNewsPapers(this._switchNewsPaper);
//
//   @override
//   _HorizontalListOfNewsPapersState createState() =>
//       _HorizontalListOfNewsPapersState();
// }
//
// class _HorizontalListOfNewsPapersState
//     extends State<HorizontalListOfNewsPapers> {
//   NewsPapers _selectedNewsPaper = NewsPapers.CnnNews;
//   Future _selectedNewsPapers;
//   List _dummyList = [
//     NewsPapers.CnnNews,
//     NewsPapers.NtvNews,
//     NewsPapers.HaberturkNews,
//     NewsPapers.BBCNews
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//           future: _selectedNewsPapers =
//               DBHelper.getData(DBHelper.selectedNewsPapers),
//           builder: (ctx, snapshot) =>
//               snapshot.connectionState == ConnectionState.waiting
//                   ? CircularProgressIndicator()
//                   : _buildHorizontalNewsPapersList(_dummyList)),
//     );
//   }
//
//   Widget markCurrentNewsPaper() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
//     );
//   }
//
//   Widget buildNewsPaperCell({String logoUrl, NewsPapers newsPapers}) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Row(
//         children: [
//           SizedBox(width: 10),
//           Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   child: InkWell(
//                     child: Image.network(logoUrl),
//                     onTap: () {
//                       widget._switchNewsPaper(newsPapers);
//                       setState(() {
//                         _selectedNewsPaper = newsPapers;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               if (_selectedNewsPaper == newsPapers) markCurrentNewsPaper()
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHorizontalNewsPapersList(List<NewsPapers> newsPapers) {
//     return Container(
//       width: double.infinity,
//       height: 130,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             if (newsPapers.isNotEmpty)
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _getNewsPapersList(List newsPapers){
//      newsPapers.map((e) => Text("gsg"));
//
//   }
// }

import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalListOfNewsPapers extends StatefulWidget {
  final Function setCurrentNewsPaper;

  HorizontalListOfNewsPapers(this.setCurrentNewsPaper);

  @override
  _HorizontalListOfNewsPapersState createState() =>
      _HorizontalListOfNewsPapersState();
}

class _HorizontalListOfNewsPapersState
    extends State<HorizontalListOfNewsPapers> {
  List<Widget> _selectedNewsPapers = [];

  Future<void> _getSelectedNewsPapers() async {
    var dataList = await DBHelper.getData(DBHelper.selectedNewsPapers);
    _selectedNewsPapers.clear();
    dataList.forEach((savedNewsPaper) {
      AllNewsPapers.values.forEach((newsPaper) {
        if (savedNewsPaper["title"] == newsPaper.toString()) {
          addNewsPaperCell(newsPaper, savedNewsPaper["imageUrl"]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSelectedNewsPapers(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: 130,
                color: Theme.of(context).cardColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 40,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                          backgroundColor: Colors.green.shade600,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(NewspaperSelectionScreen.routeName);
                        },
                      ),
                      SizedBox(width: 10),
                      Row(children: _selectedNewsPapers),
                    ],
                  ),
                ),
              ));
  }

  void _setCurrentNewsPaper(AllNewsPapers newsPaper) {
    widget.setCurrentNewsPaper(newsPaper);
  }

  void addNewsPaperCell(AllNewsPapers newsPaper, String logoUrl) {
    _selectedNewsPapers.add(InkWell(
      onTap: () {
        _setCurrentNewsPaper(newsPaper);
      },
      onLongPress: () {
        _showDeleteDialog(newsPaper);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black38, width: 2),
          ),
          //color: Colors.green,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              logoUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    ));
  }

  void _showDeleteDialog(AllNewsPapers newsPaper) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Bu gazeteyi silmek istedğinize emin misiniz?"),
              actions: [
                TextButton(
                    onPressed: () {
                      _deleteNewsPaper(newsPaper);
                    },
                    child: Text("Sil")),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("İptal")),
              ],
            ));
  }

  Future<void> _deleteNewsPaper(AllNewsPapers newsPaper) async {
    await DBHelper.deleteData(
        DBHelper.selectedNewsPapers, newsPaper.toString());
    setState(() {
      _selectedNewsPapers.clear();
      Navigator.of(context).pop();
    });
  }
}

class NewsPaperCell extends StatelessWidget {
  final AllNewsPapers newsPaper;
  final String logoUrl;

  NewsPaperCell(this.newsPaper, this.logoUrl);

  Future<void> _getSelectedNewsPapers() async {
    var dataList = await DBHelper.getData(DBHelper.selectedNewsPapers);
    dataList.forEach((savedNewsPaper) {
      if (savedNewsPaper["title"] == newsPaper.toString()) {
        //addNewsPaperCell(newsPaper, savedNewsPaper["imageUrl"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _setCurrentNewsPaper(newsPaper);
      },
      onLongPress: () {
        // _showDeleteDialog();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black38, width: 2),
          ),
          //color: Colors.green,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              logoUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  void _setCurrentNewsPaper(AllNewsPapers newsPaper) {
    //widget.setCurrentNewsPaper(newsPaper);
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Bu gazeteyi silmek istedğinize emin misiniz?"),
              actions: [
                TextButton(onPressed: _deleteNewsPaper, child: Text("Sil")),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("İptal")),
              ],
            ));
  }

  void _deleteNewsPaper() {}
}
