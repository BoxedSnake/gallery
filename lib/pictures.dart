
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({Key? key}) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  final _suggestions = <>[];

  bool type=false;
  Widget _buildSuggestions(bool type) {

    Widget gridview() {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildTile(_suggestions[index]);
        },
      );
    };

    Widget listview() {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildList(_suggestions[index]);
        },
      );
    };

    return type ? gridview() : listview();
  } //buildsuggestion
  @override
  Widget build(BuildContext context) {


    return Container();
  }
}


