import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/model/imageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery/view/image/row_piece.dart';

class listImage extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final bool imageButtonEnabled;

  listImage(this.snapshot, this.imageButtonEnabled);

  @override
  _listImageState createState() => _listImageState();
}

class _listImageState extends State<listImage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

        var docId = document.id;
        return RowImage(data, docId, widget.imageButtonEnabled);
      }).toList(),
    );

    // trailing: moreoptions());
  }
}
