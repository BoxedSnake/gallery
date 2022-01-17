import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailView extends StatefulWidget {
  final imageData;
  final imageId;

  ImageDetailView(this.imageData, this.imageId);

  @override
  _ImageDetailViewState createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  timeConverstion() {
    var date = DateTime.fromMicrosecondsSinceEpoch(
        widget.imageData['dateUploaded'].microsecondsSinceEpoch);
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///image container
          // Container(
          //   child: PhotoView(
          //     imageProvider:
          //         NetworkImage(widget.imageData['fileStorageLocation']),
          //
          //   ),
          // ),
          Container(
            color: Colors.white30,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(10),
              minScale: 0.5,
              maxScale: 10,
              child: Padding(
                padding: const EdgeInsets.all(5),
                // padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  widget.imageData['fileStorageLocation'],
                  scale: 2,
                ),
              ),
            ),
          ),

          ///image detail container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(children: <Widget>[
              ///Displays the userID of the uploaded image
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Image Name: ",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                        textAlign: TextAlign.start,
                      ),
                      Text("${widget.imageData['DisplayName']}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    ]),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(children: <Widget>[
                  Text(
                    "Uploaded by: ",
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    textAlign: TextAlign.start,
                  ),
                  Text("${widget.imageData['UploadedBy']}",
                      style: const TextStyle(fontSize: 14, color: Colors.blue)),
                ]),
              ),

              Divider(),

              ///Displays the date uploaded
              Column(
                children: <Widget>[
                  Text("Uploaded on: ",
                      style: const TextStyle(fontSize: 14, color: Colors.blue)),
                  Text(timeConverstion(),
                      style: const TextStyle(fontSize: 14, color: Colors.blue)),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
