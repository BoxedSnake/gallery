import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';

enum imageMenu {
  Share,
  Rename,
  Remove,
}

class moreoptions extends StatefulWidget {
  final imageMeta;

  moreoptions(this.imageMeta);

  @override
  _moreoptionsState createState() => _moreoptionsState();
}

class _moreoptionsState extends State<moreoptions> {
  var menuOption = imageMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<imageMenu>(
      onSelected: (menuOption) {
        switch (menuOption) {
          case imageMenu.Share:
            // TODO: Handle this case.
          print('shareImage');
            Database().shareImage(widget.imageMeta['fileName'],
                widget.imageMeta['Shared to Users']);

            break;
          case imageMenu.Rename:
            // TODO: Handle this case.
            print('renameImage');
            Database().renameImage(widget.imageMeta['fileName'],
                widget.imageMeta['DisplayName']);

            break;
          case imageMenu.Remove:
            print('removeImage');
            Database().removeImage(widget.imageMeta['fileName']);

            // TODO: Handle this case.
            break;
        }
      },
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: imageMenu.Share,
            child: Text("Share"),
          ),
          const PopupMenuItem(
            value: imageMenu.Rename,
            child: Text("Rename"),
          ),
          const PopupMenuItem(
            value: imageMenu.Remove,
            child: Text("Remove"),
          ),
        ];
      },
    );
  }
}
