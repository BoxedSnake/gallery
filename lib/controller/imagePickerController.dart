import 'package:flutter/material.dart';
// import 'package:gallery/model/imageModel.dart' as imagemodel;
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
  XFile? imageFile=null;


  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,

    );
    setState(() {
      imageFile = pickedFile;

    });

    Navigator.pop(context);
  }

  void _openUrl(BuildContext context) async{
    final pickedFile = await UrlImage();
    // ImagePicker().pickImage(
    //   source: ImageSource.camera,);

    // setState(() {
    //   imageFile = pickedFile;
    // });

    // Navigator.pop(context);
  }

// widget to launch image and loard from url
  Widget UrlImage(){

    return Image.network(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
        loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent? loadingProgress)
        {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ?
                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    :
                null,)
          );
        });
  }


  Future<void> uploadSelectedImage() async {

    File file = File(imageFile!.path.toString());
    String userId = auth.currentUser!.uid;
    String storedInDBName = userId.toString()+DateTime.now().toIso8601String();



    firebase_storage.SettableMetadata metadata = firebase_storage.SettableMetadata(
      cacheControl: 'max-age=60',
      customMetadata: <String, String>{
        'Display Name' : ' ',
        'Uploaded by': userId,
        'Saved' : 'false',
        'Shared to Users' : ' ',
      },

    );


     //firebase_storage.SettableMetadata fullMetadata = firebase_storage.FullMetadata as firebase_storage.SettableMetadata;

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('Images/$userId/$storedInDBName')
          .putFile(file, metadata);
    } on  firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("#"*100);
      print("Error Code has been called refer next line for more details:");
      print("$e");
      print("#"*100);
    }

    finally{

    }
  }



  Future<void>_showChoiceDialog(BuildContext context){

    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                //TODO determine needs for upload via url image
                onTap: (){
                  _openUrl(context);
                },
                title: Text("URL - In Progress"),
                leading: Icon(Icons.link,color: Colors.blue,),
              ),
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                Card(
                  child:( imageFile==null)?Text(""):
                  Image.file(
                    File(  imageFile!.path),),
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: (){
                    _showChoiceDialog(context);},
                  child: (imageFile==null)
                      ? const Text("Select Image")
                      : const Text("Replace Image",),
                ),
                (imageFile!=null)
                    ?
                Column(
                    children: [
                      //TODO: link form to current image.
                      // Form(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     hintText: 'FileName',
                      //   ),
                      // ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: uploadSelectedImage,
                        child: const Text("Upload Picture"),
                      )
                    ]
                )
                    :
                Container(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


