import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fpApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.BG_BASE,
      ),
      home: FutureBuilder(
        future: _fpApp,
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {

            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              WidgetsBinding.instance!
                  .addPostFrameCallback((_) => Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => HomePage())));
            }

            return WelcomePage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //WelcomePage(),
    );
  }
}
