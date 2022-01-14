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

class gridList extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final bool gridIsThree;
  final bool imageButtonEnabled;

  gridList(
    this.snapshot,
    this.gridIsThree,
    this.imageButtonEnabled,
  );

  @override
  _gridListState createState() => _gridListState();
}

class _gridListState extends State<gridList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: (widget.gridIsThree) ? 2 : 3,
      children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

        var docId = document.id;
        return tileImage(data,docId, widget.imageButtonEnabled);
      }).toList(),
    );
  }
}
