import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:test/welcomepage.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _Test();
}

class _Test extends State<Test> {

  final _formEmailKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('YOU&I',
                    style: TextStyle(fontSize: 60, fontFamily: 'BubblerOne')
                ),
                Text('creating lifelong connections',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 125),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: Text('Return to Welcome Page',
                    style: TextStyle(fontSize: 16, color: Colors.black,),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white60),
                      fixedSize: MaterialStateProperty.all<Size>(Size(290, 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.black)
                          )
                      )
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {

                    FirebaseFirestore.instance
                        .collection('Users')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        print(doc["DisplayName"]);
                      });
                    });

                  },
                  child: Text('Test site',
                    style: TextStyle(fontSize: 16, color: Colors.black,),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white60),
                      fixedSize: MaterialStateProperty.all<Size>(Size(290, 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.black)
                          )
                      )
                  ),
                ),
              ]
          ),
      ),
    );
  }
}

