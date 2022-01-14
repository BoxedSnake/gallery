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
import 'package:gallery/controller/sorting_method.dart';

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
  final VS = gridViewProperty();
  final database = Database();
  var imageList;
  String viewTitle = "Home";
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController searchController = TextEditingController();

  //
  // bool viewtype = true;
  // bool gridisthree = true;

  // ______________________________________________________________
  /// allow for the view modifications - completed
  void _toggleviewtype() {
    setState(() {
      // grid three
      if ( VS.gridisthree) {
        VS.listView = false;
        VS.gridisthree = false;
      }
      //grid five
      else if (!VS.gridisthree) {
        VS.gridisthree = true;
        VS.listView = false;
      }

    });
  }

  void _toggleListView() {
    //list
    setState(() {
      VS.listView = true;
    });
  }

  toggleLocked() {
    setState(() {
      VS.imageButtonEnabled = !VS.imageButtonEnabled;
    });
  }

  toggleHome() {
    setState(() {
      if (database.isHomeView != true) {
        viewTitle = "Home";
        database.toggleHomeView();
        imageList = database.querySnapshot();
      }
    });
    print(database.isHomeView);
    print(database.querySnapshot().toString());
  }

  toggleShared() {
    setState(() {
      if (database.isHomeView == true) {
        viewTitle = "Shared";
        database.toggleHomeView();
        imageList = database.querySnapshot();
      }

      print(database.isHomeView);
      print(database.querySnapshot().toString());
    });
    print(database.isHomeView);
    print(database.querySnapshot().toString());
  }

  void showSortMenu(){

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
          title: Text(viewTitle),
          // title: const Text('Gallery'),
          actions: [
            IconButton(
              icon: Icon(Icons.grid_view_outlined),
              onPressed: _toggleviewtype,
            ),
            GestureDetector(
              onLongPress: SortOptions().
              child: IconButton(
                icon: Icon(Icons.sort_outlined),
                onPressed: _toggleListView,
              ),
              // onLongPress: SortOptions(),

            ),
            IconButton(
              icon: Icon(Icons.lock_outlined),
              onPressed: toggleLocked,
            ),

            // IconButton(onPressed: _expandLayout, icon: icon)
          ]),
      extendBody: true,
      // body: imageDisplay(VS.listView, VS.gridisthree, VS.imageButtonEnabled, suggestions),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
              onChanged: (value) {
                setState(() {
                  String searchpara = searchController.text;
                  database.searchKey = searchpara;
                  imageList = database.querySearch();
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Add a valid name";
                }
              },
            ),
          ),
        ),
        Expanded(
          child: imageDisplay(
              VS.listView, VS.gridisthree, VS.imageButtonEnabled, imageList),
        ),
      ]),

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
        color: Colors.blue,
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
                    onPressed: toggleHome,
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
                    onPressed: toggleShared,
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
