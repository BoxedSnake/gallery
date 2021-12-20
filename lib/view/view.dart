import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';




class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}
// enum viewStyle{gridthree,gridfive,list};
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _RandomWordsState extends State<RandomWords> {
  //___________________________________________________________
  final _suggestions = <WordPair>[];
  var _biggerFont = TextStyle(fontSize: 18.0);
  bool viewtype = true;
  bool gridisthree = true;

  // ______________________________________________________________

  void _toggleviewtype() {
    setState(() {
      viewtype = !viewtype;
      // viewtype? false:true;
    });
  }

  toggleliked(isLiked) {
    setState(() {

    });
  }

  Future<void> _signout() async{
    await FirebaseAuth.instance.signOut();
  }

  void _home() {
    setState(() {
      _biggerFont = TextStyle(fontSize: 15.0);
    });
  }

  //thumbnil button test________________________________________________

  // This is the type used by the popup menu below.

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).

  Widget imagemenu(){
    var _selection;
    return PopupMenuButton<WhyFarther>(
      onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.harder,
          child: Text('Working a lot harder'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.smarter,
          child: Text('Being a lot smarter'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.selfStarter,
          child: Text('Being a self-starter'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.tradingCharter,
          child: Text('Placed in charge of trading charter'),
        ),
      ],
    );
  }
  //________________________________________________




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery'), actions: [
        IconButton(
          icon: Icon(Icons.grid_view_outlined),
          onPressed: _toggleviewtype,
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
      body: _buildSuggestions(viewtype),

      bottomNavigationBar: _bottomNavBar(),

      floatingActionButton: FloatingActionButton(
          onPressed:_signout,
          child: Icon(Icons.add_a_photo_outlined)),
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
              onPressed: imagemenu,
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
          style: _biggerFont,
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

  Widget _bottomNavBar() {
    return BottomAppBar(
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
                  const Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    tooltip: 'Shows shared photos',
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.people_outlined),
                  ),
                  const Text(
                    "Shared",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
