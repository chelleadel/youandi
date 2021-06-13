import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:test/welcomepage.dart';

class Test3 extends StatefulWidget {
  @override
  _Test3 createState() => _Test3();
}

class _Test3 extends State<Test3> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            var userDocument = snapshot.data;

            return Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 100,),
                  Text("AAA"),
                  new ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return new ListTile(
                        title: new Text(data['DisplayName']),
                        subtitle: new Text(data['Gender']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}