import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gallery/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:gallery/main.dart';


//palceholder_______________________________________________________________
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),);
  }
}

//palceholder_______________________________________________________________
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return GestureDetector(
            onTap: () {FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
    },
            child: SignInScreen(
              headerBuilder: (context,constraints,_){
                  return Padding(padding: EdgeInsets.all(20),
                  child: Container(),);
                },
                providerConfigs:[
                  EmailProviderConfiguration(),
                ],
              ),
          );


          // return Scaffold(
          //     resizeToAvoidBottomInset: false,
          //     body: SignInScreen(
          //       providerConfigs:[
          //         EmailProviderConfiguration(),
          //       ],
          //     ),
          //   );
        }
        // Render your application if authenticated
        return MyApp();
      },
    );
  }
}
//palceholder_______________________________________________________________

