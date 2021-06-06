import 'package:flutter/material.dart';
import 'package:test/question1.dart';
import 'package:test/question2.dart';
import 'package:test/question3.dart';

class Question15 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.yellow[50],
        ),
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pair me with',
                        style: TextStyle(fontSize: 48,
                          fontFamily: 'BubblerOne',
                          color: Colors.black,),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Female',
                          style: TextStyle(fontSize: 16, color: Colors.white,),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Male',
                          style: TextStyle(fontSize: 16, color: Colors.white,),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Both',
                          style: TextStyle(fontSize: 16, color: Colors.white,),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question1()),
                          );
                        },
                        child: Text('Next',
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
                )
            )
        )
    );
  }
}