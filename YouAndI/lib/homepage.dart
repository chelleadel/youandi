import 'package:flutter/material.dart';
import 'package:test/chat.dart';
import 'package:test/profile.dart';
import 'package:test/constants.dart';

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
        backgroundColor: Constants.BG_BASE,
        body: _pageOptions[selectedPage],
        bottomNavigationBar:
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.message, size: 30), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
          ],
          selectedItemColor: Constants.CHAT_BASE_DARK,
          elevation: 5.0,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: selectedPage,
          backgroundColor: Constants.BG_BASE,
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        )
    );
  }
}