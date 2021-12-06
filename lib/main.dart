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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galleryaa'),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view_outlined),
          onPressed: (){},),
          IconButton(
            icon: Icon(Icons.sort_outlined),
          onPressed: (){},),
          IconButton(
            icon: Icon(Icons.lock_outlined),
          onPressed: (){},),

          // IconButton(onPressed: _expandLayout, icon: icon)

        ]
      ),
      body: Text("placeholder"),



      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
          children: <Widget>[
            // Container(height: 50.0),
            IconButton(
              iconSize: 50,
              onPressed: (){},
              tooltip: 'Shows local photos',
              padding: EdgeInsets.symmetric(horizontal: 100),
              icon: const Icon(Icons.home_outlined),

            ),

            const Spacer(),

            IconButton(
              iconSize: 50,
              onPressed: (){},
              tooltip: 'Shows shared photos',
              padding: EdgeInsets.only(right: 100),

              icon: const Icon(Icons.people_outlined),

            )

          ],
          ),
        )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add_a_photo_outlined)
      ),
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
  }//buildrow

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i) {
        if(i.isOdd) return const Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length){
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


    return MaterialApp (
      title: 'Startup Name Generator',
      home: RandomWords(),

    );



  }
}