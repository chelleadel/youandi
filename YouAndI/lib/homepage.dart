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
        backgroundColor: Colors.yellow[50],
        body: _pageOptions[selectedPage],
        bottomNavigationBar: true ?
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.message, size: 30), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
          ],
          selectedItemColor: Colors.cyan.shade800,
          elevation: 5.0,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: selectedPage,
          backgroundColor: Colors.yellow[50],
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        ) : null
    );
  }
}