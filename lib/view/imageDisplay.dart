import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/view.dart';
import 'package:path/path.dart';
import 'package:gallery/controller/dbController.dart';

// class imageDisplay extends StatefulWidget {
//   const imageDisplay({Key? key}) : super(key: key);
//
//
//   @override
//   _imageDisplayState createState() => _imageDisplayState();
// }
//
//
// class _imageDisplayState extends State<imageDisplay> {

enum ImageMenu { Share, Rename, Remove }

bool get enabledImage => false;

bool get quantity => false;

bool get type => false;
List<List<String>> imageList = [];

// togglebool(bool isLiked) {
//   setState(() {
//     isLiked = !isLiked;
//   });
// }

Widget moreoptions() {
  return PopupMenuButton<ImageMenu>(
    onSelected: (ImageMenu) {},
    icon: const Icon(Icons.more_vert),
    itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(
          value: ImageMenu.Share,
          child: Text("Share"),
        ),
        PopupMenuItem(
          value: ImageMenu.Rename,
          child: const Text("Rename"),
          onTap: () {},
        ),
        const PopupMenuItem(
          value: ImageMenu.Remove,
          child: Text("Remove"),
        ),
      ];
    },
  );
}

Widget _buildTile(
  bool interfaceButtons,
) {
  bool isLiked = false;
  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
            'https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
        fit: BoxFit.cover,
      )),
      child: (interfaceButtons)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                moreoptions(),
                Spacer(),
                IconButton(
                  onPressed: () {
                    isLiked = !isLiked;
                  },
                  // onPressed: togglebool(isLiked),
                  icon: (isLiked)
                      ? Icon(CupertinoIcons.heart_fill)
                      : Icon(CupertinoIcons.heart),
                )
              ],
            )
          : Container());
}

Widget _buildList(WordPair pair) {
  bool isLiked = false;

  return ListTile(
      leading: IconButton(
        onPressed: () {
          isLiked = !isLiked;
        },
        // onPressed: togglebool(isLiked),
        icon: (isLiked)
            ? Icon(CupertinoIcons.heart_fill)
            : Icon(CupertinoIcons.heart),
      ),
      title: Text(
        pair.asPascalCase,
      ),
      subtitle: Text(
        "Date Uploaded: " + DateTime.now().toString() + "\nSize: 1kB",
        style: TextStyle(fontSize: 10),
      ),
      trailing: moreoptions());
}

Widget buildSuggestions(
    bool type, bool quantity, bool enabledImage, suggestions) {
  Widget gridview() {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: (quantity) ? 3 : 4,
      children: [
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
        _buildTile(enabledImage),
      ],
    );
  }

  ;

  Widget listview() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        if (index >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildList(suggestions[index]);
      },
    );
  }

  ;

  return type ? listview() : gridview();
} //buildsuggestion

@override
Widget build(BuildContext context) {
  return buildSuggestions(type, quantity, enabledImage, imageList);
}

// }
