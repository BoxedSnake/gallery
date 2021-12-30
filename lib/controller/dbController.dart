import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
enum ImageSourceType { gallery, camera }

class FireStorageService extends ChangeNotifier {

  static Future<dynamic> loadImage(BuildContext context, String Image) async{
      return await storage.ref().child(Image).getDownloadURL();
  }

}



//
//
// Future<Widget> GetImage(BuildContext context, String imageName) async {
//   Image image;
//   image = await FireStorageService.loadImage(context, imageName).then((value){
//     image = Image.network(
//       value.toString(),
//       fit: BoxFit.scaleDown,
//     );
//   });
//   return image;
// }


