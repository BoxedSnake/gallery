import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/imagePickerController.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/imageDisplay.dart';
import 'package:gallery/controller/imagePickerController.dart';


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// enum viewStyle{gridthree,gridfive,list};
enum ImageViews { gridThree, gridFive, list }

enum ImageMenu { Share, Rename, Remove }

class gridViewProp {
  bool listView = false;
  bool gridisthree = true;
}


class _RandomWordsState extends State<RandomWords> {
  //___________________________________________________________
  var suggestions = <WordPair>[];
  var biggerFont = TextStyle(fontSize: 18.0);
  var VS = new gridViewProp();
  //
  // bool viewtype = true;
  // bool gridisthree = true;

  // ______________________________________________________________

  void _toggleviewtype() {
    setState(() {
      // grid three
      if (!VS.listView && VS.gridisthree) {
        // VS.listView=!VS.listView;
        VS.gridisthree = false;
        print(VS.gridisthree);
        print(VS.listView);
      }
      //grid five
      else if (!VS.listView && !VS.gridisthree) {
        VS.gridisthree = true;
        VS.listView = true;
        print(VS.gridisthree);
        print(VS.listView);
      }
      //list
      else if (VS.listView && VS.gridisthree) {
        VS.gridisthree = true;
        VS.listView = false;
        print(VS.gridisthree);
        print(VS.listView);
      }
    });
  }

  toggleliked(isLiked) {
    setState(() {});
  }

  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut();
  }

  void _home() {
    setState(() {});
  }

  //thumbnil button test________________________________________________

  // This is the type used by the popup menu below.

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).

  //________________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: _signout,
          ),
          title: const Text('Gallery'), actions: [
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
      extendBody: true,
      body: buildSuggestions(VS.listView, VS.gridisthree, suggestions),
      // body: buildSuggestions(viewSetting.viewtype, viewSetting.gridisthree, suggestions),

      bottomNavigationBar: _bottomNavBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => imagePicker()),
            );
          },
          child: Icon(Icons.add_a_photo_outlined)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // _buildSuggestions(),
    );
  }

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
