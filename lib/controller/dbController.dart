import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

enum ImageSourceType { gallery, camera }

class dbImageController extends StatefulWidget {
  const dbImageController({Key? key}) : super(key: key);

  @override
  _dbImageControllerState createState() => _dbImageControllerState();
}

class _dbImageControllerState extends State<dbImageController> {
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = XFile(pickedFile.path);
    });
  }





  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
