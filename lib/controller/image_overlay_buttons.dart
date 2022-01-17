import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';

enum imageMenu {
  Share,
  Rename,
  Remove,
}

class moreoptions extends StatefulWidget {
  final imageMeta;
  final imageId;

  moreoptions(this.imageMeta, this.imageId);

  @override
  _moreoptionsState createState() => _moreoptionsState();
}

class _moreoptionsState extends State<moreoptions> {
  var menuOption = imageMenu;
  bool _validate = false;
  TextEditingController rename = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<imageMenu>(
      onSelected: (menuOption) {
        switch (menuOption) {
          case imageMenu.Share:
            // TODO: Handle this case.
            print('shareImage');
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("Share Image"),
                content: Text("Do you want to share this picture?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Database().shareImage(widget.imageId, widget.imageMeta['Shared to Users']);

                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            break;
          case imageMenu.Rename:
            // TODO: Handle this case.
            print('renameImage');
            // AlertDialog()
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("Rename Image"),
                content: TextField(
                  controller: rename,
                  decoration: InputDecoration(
                    hintText: widget.imageMeta['DisplayName'],
                    labelText: "Rename Image",
                    errorText: _validate ? 'Title Can\'t Be Empty' : null,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Database().renameImage(widget.imageId, rename.text);
                      Navigator.pop(context, 'OK');
                      rename.clear();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            );

            break;
          case imageMenu.Remove:
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("Remove Image"),
                content: Text("Are you sure you want to delete?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Database().removeImage(widget.imageId);
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            );
            // TODO: Handle this case.
            break;
        }
      },


      icon: const Icon(Icons.more_vert,
      color: Colors.blue,),
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
