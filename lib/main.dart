import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

//palceholder_______________________________________________________________
class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthGate(),);
  }
}
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs:[
              EmailProviderConfiguration(),
            ],
          );
        }
        // Render your application if authenticated
        return MyApp();
      },
    );
  }
}
//palceholder_______________________________________________________________



//palceholder_______________________________________________________________

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}
// enum viewStyle{gridthree,gridfive,list};

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  var _biggerFont = TextStyle(fontSize: 18.0);
  bool viewtype = true;
  bool gridisthree = true;

  void _toggleviewtype() {
    setState(() {
      if (viewtype) {
        viewtype = false;
      } else {
        viewtype = true;
      }
      // viewtype? false:true;
    });
  }

  void _home() {
    setState(() {
      _biggerFont = TextStyle(fontSize: 15.0);
    });
  }

  void _shared() {
    setState(() {
      _biggerFont = TextStyle(fontSize: 30.0);
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

  Widget _buildList(WordPair pair) {
    bool isLiked = false;

    Widget likedIcon() {
      return isLiked? Icon(CupertinoIcons.heart_fill): Icon(CupertinoIcons.heart);}

    void toggleliked() {
      setState(() {
        if (isLiked) {
          isLiked = false;
        }
        else {
          isLiked = true;
        }
      });
    };

    return ListTile(
        leading: IconButton(onPressed: () {}, icon: likedIcon()),
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}
