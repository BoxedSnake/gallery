import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/uploadImage.dart';
import 'dbController.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class imagePicker extends StatefulWidget {
  const imagePicker({Key? key}) : super(key: key);

  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  XFile? imageFile;
  TextEditingController fileNameController = TextEditingController();
  File? file;
  // final Database db = Database();

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  Future<void> _openUrl(BuildContext context) async {
    final pickedFile = await UrlImage();
    // ImagePicker().pickImage(
    //   source: ImageSource.camera,);

    // setState(() {
    //   imageFile = pickedFile;
    // });

    // Navigator.pop(context);
  }

// widget to launch image and loard from url
  Widget UrlImage() {
    return Image.network(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return Center(
          child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ));
    });
  }

  Future<void> uploadSelectedImage() async {
    file = File(imageFile!.path.toString());
    String displayName = fileNameController.text.toString();
    String storedInDBName =
        Database().getCurrentUserId() + DateTime.now().toIso8601String();
    var filepath = 'Images/${Database().getCurrentUserId()}/$storedInDBName';

    // String imageUrl = await cloudStorageDownloadUrl(filepath);

    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      cacheControl: 'max-age=60',
      customMetadata: <String, String>{
        'Uploaded by': Database().getCurrentUserId(),
      },
    );

// do the addto firebase

    final uploadTask = firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .putFile(file!, metadata);

    UploadTask? task = FirebaseApi.uploadFile(filepath, file!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    Database().firestoreAddImage(displayName, storedInDBName, downloadUrl);
    // firebase_storage.TaskSnapshot.

    ///upload selected image to cloud storage and metadata to firstore
    // void postUpload()async{
    //   String imageUrl = await cloudStorageDownloadUrl(filepath);
    //   firestoreAddImage(displayName,storedInDBName,imageUrl);
    //   Navigator.pop(context);
    // }

    ///prep for uploading in progress code
    // firebase_storage.TaskSnapshot imageUploadInProgress = await uploadTask(() => Navigator.pop(context));
    ///failed code for getting download url
    // firebase_storage.TaskSnapshot imageUploadComplete = await uploadTask.whenComplete(() => postUpload);
    /// below is basic but working code
    firebase_storage.TaskSnapshot imageUploadComplete =
        await uploadTask.whenComplete(() => Navigator.pop(context));

    Widget uploadingImage() {
      return AlertDialog(
        title: Text("Uploading"),
        content: Column(
          children: [],
        ),
      );
    }

    //
    // firebase_storage.FirebaseStorage
    // final firebase_storage.FirebaseStorage firebaseStorageRef = FirebaseStorage.instance
    //     .ref()
    //     .child('$path/${userID}_${timeStamp}_${number}_${tag}.jpg');
    // StorageUploadTask uploadTask =
    // firebaseStorageRef.putFile(image);
    // StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    // var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    // if (uploadTask.isComplete) {
    //   final String url = downloadUrl.toString();
    //   print(url);
    //   //Success! Upload is complete
    // } else {
    //   //Error uploading file
    // }

    //firebase_storage.SettableMetadata fullMetadata = firebase_storage.FullMetadata as firebase_storage.SettableMetadata;

    try {
      uploadTask;

      imageUploadComplete;
    } on firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("#" * 100);
      print("Error Code has been called refer next line for more details:");
      print("$e");
      print("#" * 100);
    } finally {}
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                  // Divider(height: 1,color: Colors.blue,),
                  // ListTile(
                  //   //TODO determine needs for upload via url image
                  //   onTap: (){
                  //     _openUrl(context);
                  //   },
                  //   title: Text("URL - In Progress"),
                  //   leading: Icon(Icons.link,color: Colors.blue,),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  final keyName = Key("imageName");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Pick Image Camera"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: (imageFile == null)
                      ? const Text("Select Image")
                      : const Text("Replace Image"),
                ),
                (imageFile != null)
                    ? Column(children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: fileNameController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter name for picture.',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        MaterialButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: uploadSelectedImage,
                          child: const Text("Upload Picture"),
                        ),

                        Card(
                          child: (imageFile == null)
                              ? Text("")
                              : Image.file(
                                  File(imageFile!.path),
                                  scale: 10,
                                ),
                        ),
                        //TODO: link form to current image.
                        // Form(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     hintText: 'FileName',
                        //   ),
                        // ),
                      ])
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
