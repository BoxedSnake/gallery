import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';
import 'package:gallery/model/imageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery/controller/image_overlay_buttons.dart';
import 'package:intl/intl.dart';
import 'package:gallery/controller/dbController.dart';

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
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             SelectImage(widget.imageData['Download URL']))),
                child: Image.network(widget.imageData['fileStorageLocation'],
                    // width: 300, height: 300,
                    // fit: BoxFit.cover,
                  scale: 2,

                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(children: <Widget>[
//Displays the image name
//               Text(widget.imageData['fileStorageLocation'],
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                       color: Colors.orange)),

//Displays the userID of the uploaded image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Image Name: ${widget.imageData['DisplayName']}",
                    style: const TextStyle(fontSize: 14, color: Colors.blue)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Uploaded by: ${widget.imageData['UploadedBy']}",
                    style: const TextStyle(fontSize: 14, color: Colors.blue)),
              ),

//Displays the date uploaded
              Text("Uploaded on: " + timeConverstion(),
                  style: const TextStyle(fontSize: 14, color: Colors.blue)),
            ]),
          ),
        ],
      ),
    );
  }
}
