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
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
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
                  child: ( imageFile==null)?const Text("Select Image"):const Text("Replace Image",),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


