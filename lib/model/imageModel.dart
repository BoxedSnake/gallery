import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';



final FirebaseAuth auth = FirebaseAuth.instance;


String getUserId() {
  return auth.currentUser!.uid;
}


class Image (String imageURL, ){
  String imageURL = "null";
  String imageName = "null";
  String Uploader = getUserId();

}