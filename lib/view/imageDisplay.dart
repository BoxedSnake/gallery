import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/view.dart';
import 'package:path/path.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/view/image/list.dart';

enum ImageMenu { Share, Rename, Remove }

class imageDisplay extends StatefulWidget {
  final bool listView;
  final bool gridIsThree;
  final bool imageButtonEnabled;
  final imageList;


  imageDisplay(this.listView, this.gridIsThree, this.imageButtonEnabled,
      this.imageList);

  @override
  _imageDisplayState createState() => _imageDisplayState();
}

class _imageDisplayState extends State<imageDisplay> {


  Widget moreoptions() {
    return PopupMenuButton<ImageMenu>(
      onSelected: (ImageMenu) {},
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: ImageMenu.Share,
            child: Text("Share"),
          ),
          PopupMenuItem(
            value: ImageMenu.Rename,
            child: const Text("Rename"),
            onTap: () {},
          ),
          const PopupMenuItem(
            value: ImageMenu.Remove,
            child: Text("Remove"),
          ),
        ];
      },
    );
  }


  Widget buildSuggestions() {
    Widget gridview() {
      return StreamBuilder<QuerySnapshot>(
          stream: widget.imageList,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                  ));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading...',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ))
                  ]);
            }

            if (snapshot.data!.docs.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  child: const Text("No results",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      )));
            }
            else {
              return GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: (widget.gridIsThree) ? 3 : 4,
                children: widget.imageList.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String,dynamic>;
                  var selectedDoc = document.id;}
                  ).toList(),);
            }
    });

    Widget listview() {
      return ListView.builder(
          padding: const EdgeInsets.all(16.0),stream

    }

    return listImage();
  }

  ,

  );
}

;

return
widget.listView
?
listview
(
) :

gridview();} //buildsuggestion

@override
Widget build(BuildContext context) {
  return buildSuggestions();
}}
