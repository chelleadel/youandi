import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/test2.dart';


import 'package:test/welcomepage.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);


  @override
  State<Test> createState() => _Test();
}

class _Test extends State<Test> {

  var _testing;

  @override
  Widget build(BuildContext context) {

    Future<void> getData() async {
      await FirebaseFirestore.instance.collection('Users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _testing = doc["DisplayName"];
          print(_testing);

        });
      });
    }

    getData();



    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageProfile(),
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
                  style: TextStyle(fontSize: 16, color: Colors.white,),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                    fixedSize: MaterialStateProperty.all<Size>(Size(290, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.black)
                        )
                    )
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    print("Done");
                  });
                },
                child: Text('Test',
                  style: TextStyle(fontSize: 16, color: Colors.black,),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    fixedSize: MaterialStateProperty.all<Size>(Size(290, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.black)
                        )
                    )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 16,),
                    Text(
                      "Gender:",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      _testing == null ? "" : _testing,
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Test2()),
                  );
                },
                child: Text('Test site 2',
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



  Widget imageProfile() {
    return Stack(children: <Widget>[
      CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/Demo_Pic.jpg")),
    ],);
  }
}
