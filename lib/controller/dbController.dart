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
  bool isHomeView = true;

  toggleHomeView() {
    isHomeView = !isHomeView;
  }

  /// authenticate functions
  String getCurrentUserId() {
    return auth.currentUser!.uid;
  }

  ///Signout function
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  ///query header set
  queryHeader() {
    var query;
    String queryLocation = isHomeView ? "UploadedBy" : "Shared to Users";
    var refValue = isHomeView ? getCurrentUserId() : true;
    if (isHomeView) {
      var query =
          firebaseImages.where("UploadedBy", isEqualTo: getCurrentUserId());
      print(query);

      return query;
    } else {
      var query = firebaseImages.where("Shared to Users", isEqualTo: true);
      print(query);

      return query;
    }
  }

  querySnapshot() {
    var query = queryHeader().snapshots();
    return query;
  }

  /// Cloud Storage __________________________________________
  ///Cloud Storage Download Url
  ///
  Future<String> cloudStorageDownloadUrl(String imageAddress) async {
    String downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref(imageAddress)
        .getDownloadURL();
    // print(downloadUrl);
    return downloadUrl;
  }

  /// Firestore functions________________________________________________
  ///Firestore add new image
  ///
  Future<void> firestoreAddImage(
      String imageName, String imageAddress) {
      // String imageName, String fileName, String imageAddress) {
    // String fileAddress = cloudStorageDownloadUrl(imageAddress) as String;
    // print(fileAddress);

    return firebaseImages
        .add({
          'DisplayName': imageName,
          // 'fileName': fileName,
          'UploadedBy': getCurrentUserId(),
          'Saved': false,
          'Shared to Users': false,
          'dateUploaded': DateTime.now(),
          'dateModified': DateTime.now(),
          'fileStorageLocation': imageAddress
        })
        .then((value) => print("Image Added"))
        .catchError((error) => print("Failed to add image: $error"));
  }

  ///Firestore favourite/unfavourite current image
  Future<void> favouriteImage(String fileName, bool savedValue) {
    return firebaseImages
        .doc(fileName)
        .update(
          {
            'Saved': !savedValue,
            'dateModified': DateTime.now(),
          },
        )
        .then((value) => print("Image is Saved: $savedValue"))
        .catchError(
            (error) => print("Failed to Save/unsave image due to: $error"));
  }

  ///More Options firestore methods_________________

  ///Firestore rename current image
  Future<void> renameImage(
      String fileName,
      String imageName,
  ) {
    return firebaseImages
        .doc(fileName)
        .update(
          {
            'DisplayName': imageName,
            'dateModified': DateTime.now(),
          },
        )
        .then((value) => print("Image renamed"))
        .catchError((error) => print("Failed to rename image: $error"));
  }

  ///Firestore Sharing current image
  Future<void> shareImage(String fileName, bool shareValue) {
    print(shareValue);
    print(fileName);

    return firebaseImages
        .doc(fileName)
        // .set(
        .update(
          {
            'Shared to Users': !shareValue,
            'dateModified': DateTime.now(),
          },
          // SetOptions(merge: true),
        )
        .then((value) => print("Image is Shared: $shareValue"))
        .catchError(
            (error) => print("Failed to Shared/Unshared image due to: $error"));
  }

  ///Firestore Remove current image
  Future<void> removeImage(String fileName) {
    return firebaseImages
        .doc(fileName)
        .delete()
        .then((value) => print("Image is removed:$fileName"))
        .catchError((error) => print("Failed to remove image due to: $error"));
  }
}
