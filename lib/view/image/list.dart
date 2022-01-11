import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/model/imageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery/controller/image_overlay_buttons.dart';

class listImage extends StatefulWidget {
  final imageData;
  final bool interfaceButtons;

  listImage(this.imageData, this.interfaceButtons);

  @override
  _listImageState createState() => _listImageState();
}

class _listImageState extends State<listImage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: IconButton(
          onPressed: () {
            setState(() {
              Database().favouriteImage(
                widget.imageData['fileName'],
                widget.imageData['Saved'],
              );
            });
          },

          icon: (widget.imageData['Saved'])
              ? Icon(CupertinoIcons.heart_fill)
              : Icon(CupertinoIcons.heart),
        ),
        title: Text(
          widget.imageData['DisplayName'],
        ),
        subtitle: Text(
          "Date Uploaded: " + widget.imageData['dateUploaded'],
          style: TextStyle(fontSize: 10),
        ),
        trailing: moreoptions(widget.imageData)
    );
        // trailing: moreoptions());
  }
}
