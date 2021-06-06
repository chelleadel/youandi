import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: Colors.yellow[50],
      ),
      home: FutureBuilder(
        future: _fpApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {
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
