import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/view.dart';



Widget _buildTile(bool interfaceButtons, ) {
  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
            fit: BoxFit.cover,
          )),
      child:(interfaceButtons)? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart))
        ],
      )
          :
          Container()
  );
}

Widget likedbutton({isliked = false}) {
  bool isLiked = false;

  Widget heart() {
    return isLiked
        ? Icon(CupertinoIcons.heart_fill)
        : Icon(CupertinoIcons.heart);
  }

  return IconButton(onPressed: () {}, icon: heart());
}

Widget _buildList(WordPair pair) {
  return ListTile(
      leading: likedbutton(),
      title: Text(
        pair.asPascalCase,
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)));
}

Widget buildSuggestions(bool type, bool quantity, bool enabledImage, suggestions) {
  Widget gridview() {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: (quantity) ? 3 : 5,
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
