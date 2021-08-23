import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/material.dart';

class NewspaperSelectionGridTile extends StatefulWidget {
  @override
  _NewspaperSelectionGridTileState createState() =>
      _NewspaperSelectionGridTileState();
  final String imageUrl;
  final String title;
  final List selectedNewsPapersTableName;
  final List<Map<String, dynamic>> savedNewsPapersList;

  NewspaperSelectionGridTile({
    @required this.title,
    @required this.imageUrl,
    @required this.selectedNewsPapersTableName,
    @required this.savedNewsPapersList,
  });
}

class _NewspaperSelectionGridTileState
    extends State<NewspaperSelectionGridTile> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _controlSavedNewsPapers();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectNewspaper,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.white,
                child: GridTile(
                    child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                )),
              ),
              if (_isSelected) Container(color: Colors.black38),
              if (_isSelected)
                Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  _controlSavedNewsPapers() {
    if (widget.savedNewsPapersList.isNotEmpty) {
      widget.savedNewsPapersList.forEach((element) {
        if (element["title"] == widget.title) {
          _isSelected = true;
        }
      });
    } else {
      _isSelected = false;
    }
  }

  Future<void> _selectNewspaper() async {
    if (!_isSelected) {
      widget.selectedNewsPapersTableName.add({
        "title": widget.title,
        "imageUrl": widget.imageUrl,
      });
      setState(() {
        _isSelected = !_isSelected;
      });
    } else {
      widget.selectedNewsPapersTableName
          .removeWhere((element) => element["title"] == widget.title);
      setState(() {
        _isSelected = !_isSelected;
      });
      await DBHelper.deleteData(
          DBHelper.selectedNewsPapersTableName, widget.title);
    }
  }
}
