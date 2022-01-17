import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/controller/image_overlay_buttons.dart';
import 'package:intl/intl.dart';
import 'package:gallery/view/image/image_detail_view.dart';

class RowImage extends StatefulWidget {
  final imageData;
  final imageId;
  final bool interfaceButtons;

  RowImage(this.imageData, this.imageId, this.interfaceButtons);

  @override
  _RowImageState createState() => _RowImageState();
}

class _RowImageState extends State<RowImage> {
  @override
  timeConverstion() {
    var date = DateTime.fromMicrosecondsSinceEpoch(
        widget.imageData['dateUploaded'].microsecondsSinceEpoch);
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(date);
    return formattedDate;
  }

  Widget build(BuildContext context) {
    return ListTile(
      leading: (widget.interfaceButtons)
          ? IconButton(
              onPressed: () {
                setState(() {
                  Database().favouriteImage(
                    widget.imageId,
                    widget.imageData['Saved'],
                  );
                });
              },
              icon: (widget.imageData['Saved'])
                  ? Icon(CupertinoIcons.heart_fill)
                  : Icon(CupertinoIcons.heart),
            )
          : Spacer(),
      title: TextButton(
        // onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ImageDetailView(widget.imageData, widget.imageId))),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: ImageDetailView(widget.imageData, widget.imageId),
            ),);},
        child: Text(
          widget.imageData['DisplayName'],
          textAlign: TextAlign.left,
        ),
      ),
      subtitle: Text(
        "Date Uploaded: " + timeConverstion(),
        style: const TextStyle(fontSize: 10),
      ),
      trailing: (widget.interfaceButtons)
          ? moreoptions(widget.imageData, widget.imageId)
          : Spacer(),
    );
  }
}
