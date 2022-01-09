import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


final FirebaseAuth auth = FirebaseAuth.instance;
final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
CollectionReference firebaseImages = FirebaseFirestore.instance.collection('userImages');



String userId = auth.currentUser!.uid;
///Firestore add new image
///
Future<void> firestoreAddImage(String imageName,String fileName, String imageAddress){

  String fileAddress = cloudStorageDownloadUrl(imageAddress) as String;
  print(fileAddress);

  return firebaseImages.doc(userId).collection(userId)
      .add({
    'DisplayName': imageName,
    'fileName': fileName,
    'UploadedBy': userId,
    'Saved': false,
    'Shared to Users': [],
    'dateUploaded' : DateTime.now(),
    'dateModfied' : DateTime.now(),
    ///TODO:address image location issue
    'fileStorageLocation' : fileAddress
  })
      .then((value) => print("Image Added"))
      .catchError((error) => print("Failed to add image: $error"));
}


///Firestore rename current image
Future<void> renameImage(String imageName,String fileName,){
  return firebaseImages.doc(userId).collection(userId).doc(fileName)
      .set({
    'DisplayName': imageName,
    'dateModfied' : DateTime.now(),
  },
    SetOptions(merge: true),
  )
      .then((value) => print("Image renamed"))
      .catchError((error) => print("Failed to rename image: $error"));
}


///Cloud Storage Download Url
///
Future<String> cloudStorageDownloadUrl(String imageAddress) async {
  String downloadUrl = await firebase_storage.FirebaseStorage.instance
      .ref(imageAddress)
      .getDownloadURL();
  return downloadUrl;

}

