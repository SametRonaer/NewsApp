import 'package:daily_newspapers/helpers/db_helper.dart';
import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/material.dart';

class NewspaperSelectionGridTile extends StatefulWidget {
  @override
  _NewspaperSelectionGridTileState createState() =>
      _NewspaperSelectionGridTileState();
  final String imageUrl;
  final String title;
  final List selectedNewsPapers;

  NewspaperSelectionGridTile({
    @required this.title,
    @required this.imageUrl,
    @required this.selectedNewsPapers,
  });
}

class _NewspaperSelectionGridTileState
    extends State<NewspaperSelectionGridTile> {
  bool _isSelected = false;

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
              GridTile(
                  child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fill,
              )),
              if (_isSelected) Container(color: Colors.black38),
              if (_isSelected) Icon(Icons.add)
            ],
          ),
        ),
      ),
    );
  }

  void _selectNewspaper() {
    setState(() {
      if (!_isSelected) {
        widget.selectedNewsPapers.add({
          "title": widget.title,
          "imageUrl": widget.imageUrl,
        });
        _isSelected = !_isSelected;
      } else {
        widget.selectedNewsPapers
            .removeWhere((element) => element["title"] == widget.title);
        _isSelected = !_isSelected;
      }
    });
    print(widget.selectedNewsPapers);
  }
}
