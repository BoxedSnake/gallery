import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/model/imageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery/controller/image_overlay_buttons.dart';

class tileImage extends StatefulWidget {
  final imageData;
  final bool interfaceButtons;

  tileImage(this.imageData, this.interfaceButtons);

  @override
  State<tileImage> createState() => _tileImageState();
}

class _tileImageState extends State<tileImage> {
  //Database().favouriteImage(widget.imageData['fileName'],widget.imageData['Saved'],),

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(widget.imageData['fileStorageLocation']),
          fit: BoxFit.cover,
        )),
        child: (widget.interfaceButtons)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  moreoptions(widget.imageData),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Database().favouriteImage(
                          widget.imageData['fileName'],
                          widget.imageData['Saved'],
                        );
                      });
                    },

                    // onPressed: togglebool(isLiked),
                    icon: (widget.imageData['Saved'])
                        ? Icon(CupertinoIcons.heart_fill)
                        : Icon(CupertinoIcons.heart),
                  )
                ],
              )
            :
            //
            null
    );
  }
}
