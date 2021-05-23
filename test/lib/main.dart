import 'package:flutter/material.dart';
import 'package:test/welcomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
      ),
      home: WelcomePage(),
    );
  }
}

