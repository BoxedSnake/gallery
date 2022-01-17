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
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(), // check for system based mode (dark or light)
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: ThemeMode.system,
      home:  const GalleryApp(),
      // home: RandomWords(),
    );
  }
}
