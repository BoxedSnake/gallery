import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';


class imagePicker extends StatefulWidget {
  const imagePicker({Key? key}) : super(key: key);

  @override
  _imagePickerState createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  XFile? imageFile=null;


  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().pickImage(
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
                    _showChoiceDialog(context);
                    },
                  child: (imageFile==null)?const Text("Select Image"):const Text("Replace Image",),
                ),
                (imageFile!=null)
                    ?
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: (){},
                  child: const Text("upload"),
                )
                    :
                Text(""),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


