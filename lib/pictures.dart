
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({Key? key}) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  final _suggestions = <WordPair>[];

  bool type=false;
  Widget _buildTile(WordPair pair) {
    return Container(
      //   child: ListTile(
      //     title: Image.network('https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
      //     // title: Text(pair.asPascalCase,style: _biggerFont),
      //     trailing:Column(
      //       children: [
      //         IconButton(
      //           onPressed: (){},
      //           icon: Icon(Icons.more_vert),
      //         ),
      //         IconButton(
      //             onPressed: (){},
      //             icon: Icon(CupertinoIcons.heart))
      //       ],
      //     )
      //   ),
      // );
        width: 420,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
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
    );
  }


  Widget likedbutton({isliked = false}){
    bool isLiked = false;



    Widget heart() {
      return isLiked? Icon(CupertinoIcons.heart_fill): Icon(CupertinoIcons.heart);
    }
    return IconButton(onPressed: (){}, icon: heart());
  }

  Widget _buildList(WordPair pair) {

    return ListTile(
        leading: likedbutton(),
        title: Text(
          pair.asPascalCase,
          // style: ,
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)
        )
    );
  }

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


