import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/feed_screen.dart';
import 'package:daily_newspapers/widgets/newspaper_selection_grid_tile.dart';
import 'package:flutter/material.dart';

class NewspaperSelectionScreen extends StatelessWidget {
  static final routeName = "/newsPaperSelectionScreen";

  final List<Map<String, dynamic>> _selectedNewsPapersTableName = [];

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
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: NewsPapers.allNewsPapersWithUrl.length,
        itemBuilder: (ctx, i) => NewspaperSelectionGridTile(
          title: NewsPapers.allNewsPapersWithUrl[i]["title"],
          imageUrl: NewsPapers.allNewsPapersWithUrl[i]["imageUrl"],
          selectedNewsPapersTableName: _selectedNewsPapersTableName,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Future<void> _saveNewsPapers(BuildContext context) async {
    Future.forEach(_selectedNewsPapersTableName, (element) async {
      await DBHelper.insert(DBHelper.selectedNewsPapersTableName, element);
    });
    Navigator.of(context).pushNamed(FeedScreen.routeName);
  }
}