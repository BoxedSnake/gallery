import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

Future uploadImage(String name) async {
  await firebase_storage.FirebaseStorage.instance
      .ref()
      .child('images')
      .child('$name.jpg');
}

// Future<void> uploadFileWithMetadata(String filePath) async {
//   File file =File(filePath);
//
//   // Create your custom metadata.
//   firebase_storage.SettableMetadata metadata = firebase_storage.SettableMetadata(
//     cacheControl: 'max-age=60',
//     customMetadata: <String, String>{
//       'userId': 'ABC123',
//     },
//   );
//   try {
//     // Pass metadata to any file upload method e.g putFile.
//     await firebase_storage.FirebaseStorage.instance
//         .ref('uploads/file-to-upload.png')
//         .putFile(file, metadata);
//   } on firebase_storage.FirebaseException catch (e) {
//     // e.g, e.code == 'canceled'
//   }
// }
