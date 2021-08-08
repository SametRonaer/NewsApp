import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/feed_screen.dart';
import 'package:daily_newspapers/widgets/newspaper_selection_grid_tile.dart';
import 'package:flutter/material.dart';

class NewspaperSelectionScreen extends StatelessWidget {
  static final routeName = "/newsPaperSelectionScreen";

  final List<Map<String, dynamic>> _selectedNewsPapers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selection Screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveNewsPapers(context);
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: NewsPapers.allNewsPapersWithUrl.length,
            itemBuilder: (ctx, i) => NewspaperSelectionGridTile(
              title: NewsPapers.allNewsPapersWithUrl[i]["title"],
              imageUrl: NewsPapers.allNewsPapersWithUrl[i]["imageUrl"],
              selectedNewsPapers: _selectedNewsPapers,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          // Container(
          //   height: 60,
          //   width: double.infinity,
          //   color: Colors.blue,
          //   child: TextButton(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text(
          //           "Done",
          //           style: TextStyle(color: Colors.white, fontSize: 20),
          //         ),
          //       ],
          //     ),
          //     onPressed: () {
          //       _saveNewsPapers(context);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _saveNewsPapers(BuildContext context) async {
    // await DBHelper.insert(DBHelper.selectedNewsPapers, {
    //   "title": widget.title,
    //   "logo": widget.imageUrl,
    // }).then((value) {
    //   _addNewsPaper();
    // });
    Future.forEach(_selectedNewsPapers, (element) async {
      await DBHelper.insert(DBHelper.selectedNewsPapers, element);
    });
    Navigator.of(context).pushNamed(FeedScreen.routeName);
  }
}
