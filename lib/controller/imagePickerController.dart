import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

void _openCamera(BuildContext context)  async{
  final pickedFile = await ImagePicker().getImage(
    source: ImageSource.camera ,
  );
  setState(() {
    imageFile = pickedFile!;
  });
  Navigator.pop(context);
}