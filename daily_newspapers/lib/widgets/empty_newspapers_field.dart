import 'package:daily_newspapers/screens/newspaper_selection_screen.dart';
import 'package:flutter/material.dart';

class EmptyNewsPapersField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          alignment: Alignment.center,
          child: TextButton.icon(
            label: Text(
              "Gazete Ekle",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(NewspaperSelectionScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
