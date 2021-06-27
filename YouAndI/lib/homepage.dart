import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/chat.dart';
import 'package:test/matching.dart';
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

    var currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {


        // Matching starts
        if (Matching.hasMaxMatches(snapshot.data!['NumberOfMatch']) == false) {
          print("Number of personal match:");
          print(snapshot.data!['NumberOfMatch']);
          Matching.findMatch(snapshot.data!['Email']);
        }


        // Matching ends

        if (snapshot.hasError)
          return Center(
            child: Text(snapshot
                .hasError
                .toString()),
          );
        return snapshot.hasData ?

        Scaffold(
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
        ) :
        Container();
      },
    );
  }
}