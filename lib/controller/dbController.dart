import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery/controller/uploadImage.dart';
import 'uploadImage.dart.';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final CollectionReference firebaseImages =
      FirebaseFirestore.instance.collection('userImages');

  /// authenticate functions
  ///
  ///
  getCurrentUserId() {
    String userId = auth.currentUser!.uid;
    return userId;
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  queryHeader(bool home) {
    String queryLocation = home ? "UploadedBy" : "Shared to Users";
    var refValue = home ? getCurrentUserId() : true;

    var query = firebaseImages
        .where(queryLocation, isEqualTo: refValue);
    return query;
  }

  querySnapshot(bool home){
    return queryHeader(home).snapshots();
  }




  ///Cloud Storage Download Url
  ///
  Future<String> cloudStorageDownloadUrl(String imageAddress) async {
    String downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref(imageAddress)
        .getDownloadURL();
    // print(downloadUrl);
    return downloadUrl;
  }

  ///Firestore add new image
  ///
  Future<void> firestoreAddImage(
      String imageName, String fileName, String imageAddress) {
    // String fileAddress = cloudStorageDownloadUrl(imageAddress) as String;
    // print(fileAddress);

    return firebaseImages
        .add({
          'DisplayName': imageName,
          'fileName': fileName,
          'UploadedBy': getCurrentUserId,
          'Saved': false,
          'Shared to Users': false,
          'dateUploaded': DateTime.now(),
          'dateModfied': DateTime.now(),

          ///TODO:address image location issue
          'fileStorageLocation': imageAddress
        })
        .then((value) => print("Image Added"))
        .catchError((error) => print("Failed to add image: $error"));
  }

  ///Firestore rename current image
  Future<void> renameImage(
    String imageName,
    String fileName,
  ) {
    return firebaseImages
        .doc(fileName)
        .set(
          {
            'DisplayName': imageName,
            'dateModfied': DateTime.now(),
          },
          SetOptions(merge: true),
        )
        .then((value) => print("Image renamed"))
        .catchError((error) => print("Failed to rename image: $error"));
  }

  ///Firestore favourite/unfavourite current image
  Future<void> favouriteImage(String fileName, bool savedValue) {
    savedValue = !savedValue;
    return firebaseImages
        .doc(fileName)
        .set(
          {
            'Saved': savedValue,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("Image is Saved: $savedValue"))
        .catchError(
            (error) => print("Failed to Save/unsave image due to: $error"));
  }
}
