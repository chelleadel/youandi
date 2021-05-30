import 'package:flutter/material.dart';
import 'package:test/chat.dart';
import 'package:test/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedPage = 0;

  final _pageOptions = [
    Chat(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: true ?
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
          ],
          selectedItemColor: Colors.black,
          elevation: 5.0,
          unselectedItemColor: Colors.blueAccent,
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        ) : null
    );
  }
}