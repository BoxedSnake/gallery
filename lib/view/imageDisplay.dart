import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/auth/login.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery/view/image/grid_piece.dart';
import 'package:gallery/view/view.dart';
import 'package:path/path.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/view/image/row_list.dart';
import 'package:gallery/view/image/grid_list.dart';

enum ImageMenu { Share, Rename, Remove }

class imageDisplay extends StatefulWidget {
  final bool listView;
  final bool gridIsThree;
  final bool imageButtonEnabled;
  var imageList;

  imageDisplay(this.listView, this.gridIsThree, this.imageButtonEnabled,
      this.imageList, {Key? key}) : super(key: key);

  @override
  _imageDisplayState createState() => _imageDisplayState();
}

class _imageDisplayState extends State<imageDisplay> {


  @override
  Widget build(BuildContext context) {
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
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading...',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ))
                  ]),
            );
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
            return widget.listView
                ? listImage(snapshot, widget.imageButtonEnabled)
                : gridList(
                snapshot, widget.gridIsThree, widget.imageButtonEnabled);
          }
        }
    );
  }
}