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
  final _biggerFont = const TextStyle(fontSize: 18.0);
  var bodytext = Text("Hello");

  // var
  void _home() {
    setState(() {
      bodytext = Text("HomePage");
    });
  }

  void _shared() {
    setState(() {
      bodytext = Text("Shared");
    });
  }

  void _yupper() {
    bodytext = Text("slkjdlfjldsfjldsx  ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galleryaa'), actions: [
        IconButton(
          icon: Icon(Icons.grid_view_outlined),
          onPressed: _yupper,
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
      body: bodytext,

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
                      onPressed: _home,
                      tooltip: 'Shows local photos',
                      color: Colors.white,
                      icon: const Icon(Icons.home_outlined),
                    ),
                    const Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    onPressed: _shared,
                    tooltip: 'Shows shared photos',

                    icon: const Icon(Icons.people_outlined),
                  ),
                  const Text(
                    "Shared",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )
                ]
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

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  } //buildrow

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
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
