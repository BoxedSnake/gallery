import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/controller/imagePickerController.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/imageDisplay.dart';
import 'package:gallery/controller/imagePickerController.dart';
import 'package:gallery/controller/dbController.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class gridViewProperty {
  bool listView = false;
  bool gridisthree = true;
  bool imageButtonEnabled = true;
}

class _GalleryAppState extends State<GalleryApp> {
  //___________________________________________________________
  var biggerFont = TextStyle(fontSize: 18.0);
  final VS = new gridViewProperty();
  final database = new Database();
  var imageList;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //
  // bool viewtype = true;
  // bool gridisthree = true;

  // ______________________________________________________________
  /// allow for the view modifications - completed
  void _toggleviewtype() {
    setState(() {
      // grid three
      if (!VS.listView && VS.gridisthree) {
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

  toggleLocked() {
    setState(() {
      VS.imageButtonEnabled = !VS.imageButtonEnabled;
    });
  }

  toggleHomeOrShared(){
    setState(() {
      database.toggleHomeView;

      imageList = database.querySnapshot();
    });
  }


  //thumbnil button test________________________________________________

  // This is the type used by the popup menu below.

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).

  //________________________________________________

  @override
  Widget build(BuildContext context) {
    imageList ??= database.querySnapshot();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: Database().signout,
          ),
          title: Text(auth.currentUser!.uid),
          // title: const Text('Gallery'),
          actions: [
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
              onPressed: toggleLocked,
            ),

            // IconButton(onPressed: _expandLayout, icon: icon)
          ]),
      extendBody: true,
      // body: imageDisplay(VS.listView, VS.gridisthree, VS.imageButtonEnabled, suggestions),
      body: imageDisplay(
          VS.listView, VS.gridisthree, VS.imageButtonEnabled, imageList),

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
                    onPressed: toggleHomeOrShared,
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
                    onPressed: toggleHomeOrShared,
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
