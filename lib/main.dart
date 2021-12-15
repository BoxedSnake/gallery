import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  var _biggerFont =  TextStyle(fontSize: 18.0);
  var bodytext  = Text("Hello");




  void _home() {
    setState(() {
      _biggerFont = TextStyle(fontSize: 10.0);
      bodytext = Text("HomePage");
    });
  }

  void _shared() {
    setState(() {
      _biggerFont = TextStyle(fontSize: 30.0);

      bodytext = Text("Shared");
    });
  }
  //
  // var _loading_random_words(){
  //   setState(() {
  //     _buildSuggestions();
  //   });  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galleryaa'), actions: [
        IconButton(
          icon: Icon(Icons.grid_view_outlined),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.sort_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.lock_outlined),
          onPressed: () {},
        ),

        // IconButton(onPressed: _expandLayout, icon: icon)
      ]),
      body: _buildSuggestions(),

      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.black,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(

                      constraints: BoxConstraints(),
                      onPressed: _home,
                      tooltip: 'Shows local photos',
                      color: Colors.white,
                      icon: const Icon(Icons.home_outlined),
                    ),
                    const Text("Home", style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
                Stack(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                  IconButton(
                    onPressed: _shared,
                    tooltip: 'Shows shared photos',
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.people_outlined),
                  ),
                  const Text("Shared",style: TextStyle(color: Colors.white,fontSize: 10,),
                  )
                ],
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: Icon(Icons.add_a_photo_outlined)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // _buildSuggestions(),
    );
  }

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
              image: NetworkImage('https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
              fit: BoxFit.cover,)
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
            ),
            Spacer(),
            IconButton(
                onPressed: (){},
                icon: Icon(CupertinoIcons.heart))
          ],
        )

    );
  }
  Widget _buildSuggestions() {
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
  } //buildsuggestion

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}
