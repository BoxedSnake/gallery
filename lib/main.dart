import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'firebase_options.dart';
import 'package:gallery/auth/login.dart';
import 'view/view.dart';






Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Login());
}

//palceholder_______________________________________________________________

//palceholder_______________________________________________________________



//palceholder_______________________________________________________________


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home:  GalleryApp(),
      // home: RandomWords(),
    );
  }
}
