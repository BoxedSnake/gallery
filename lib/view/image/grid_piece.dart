import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/controller/image_overlay_buttons.dart';

import 'image_detail_view.dart';

class tileImage extends StatefulWidget {
  final imageData;
  final imageId;
  final bool interfaceButtons;

  tileImage(this.imageData, this.imageId, this.interfaceButtons);

  @override
  State<tileImage> createState() => _tileImageState();
}

class _tileImageState extends State<tileImage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: ImageDetailView(widget.imageData, widget.imageId),
          ),
        );
      },
      child: Container(
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
                    moreoptions(widget.imageData, widget.imageId),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Database().favouriteImage(
                            widget.imageId,
                            widget.imageData['Saved'],
                          );
                        });
                      },

                      // onPressed: togglebool(isLiked),
                      icon: IconFavourites(widget.imageData['Saved'])
                         ,
                    )
                  ],
                )
              :
              //
              null),
    );
  }
}

Widget IconFavourites(bool properties) {
  Color _bgColor = Colors.black;

  return Icon(properties ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
      color: _bgColor.computeLuminance() > 0.5 ? Colors.white : Colors.blue);
}
