import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/model/imageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;




class tileImage extends StatefulWidget {
  @override
  State<tileImage> createState() => _tileImageState();
}

class _tileImageState extends State<tileImage> {
  final String imageId;

  GetImageDetails(imageId);

  // imageModel imageone = new imageModel(filename, uploader, downloadUrl, uploadDate, favourite, SharedUsers)
  @override
  Widget build(BuildContext context) {


    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
              fit: BoxFit.cover,
            )),
        child: (interfaceButtons)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            moreoptions(),
            Spacer(),

            IconButton(
              onPressed:saved,
              // onPressed: togglebool(isLiked),
              icon: (isLiked) ? Icon(CupertinoIcons.heart_fill) : Icon(
                  CupertinoIcons.heart),
            )

          ],
        )
            :
        //
        null
    );
  }
}






enum imageMenu { Share, Rename, Remove }
Widget moreoptions() {
  return PopupMenuButton<imageMenu>(
    onSelected: (ImageMenu){},
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










Widget _buildTile(bool interfaceButtons,) {

  saved(){
    setState(){
      isLiked = !isLiked;
    }
  }

  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.britannica.com/16/1016-050-8932B817/Gray-whale-breaching.jpg'),
            fit: BoxFit.cover,
          )),
      child: (interfaceButtons) ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          moreoptions(),
          Spacer(),

          IconButton(
            onPressed:saved,
            // onPressed: togglebool(isLiked),
            icon: (isLiked) ? Icon(CupertinoIcons.heart_fill) : Icon(
                CupertinoIcons.heart),
          )

        ],
      )
          :
      Container()
  );
}