import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:test/test3.dart';


import 'package:test/welcomepage.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2 createState() => _Test2();
}

class _Test2 extends State<Test2> {

  init() {
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc("2tCX4wQSRrTpswjDN1c5").get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot
                .hasError
                .toString()),
          );
        return snapshot.hasData ?
        Scaffold(
            body: Text("${snapshot.data!['DisplayName']}",)
        ) :
        Container();
      },
    );
  }

  String getData() {
    FirebaseFirestore.instance.collection('Users').where('Gender', isEqualTo: "Male")
        .snapshots().listen(
            (data) => print('grower ${data}')
    );
    return "Error";
  }
}

