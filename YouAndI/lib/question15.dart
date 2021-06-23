import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/question1.dart';
import 'package:test/question2.dart';
import 'package:test/constants.dart';
import 'package:test/question3.dart';
import 'services/firebase.dart';

// Q2- Pair me with a; 1- Female, 2- Male, 3- Both
class Question15 extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.BG_BASE,
        ),
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pair me with',
                        style: TextStyle(
                          fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q2", 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Female',
                          style: TextStyle(
                              fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.white,
                              fontFamily: Constants.BUTTON_FONT
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                  //side: BorderSide(color: Colors.black)
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q2", 2);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Male',
                          style: TextStyle(
                              fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.white,
                              fontFamily: Constants.BUTTON_FONT)
                          ,),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                  //side: BorderSide(color: Colors.black)
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q2", 3);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Both',
                          style: TextStyle(
                              fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.white,
                              fontFamily: Constants.BUTTON_FONT
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
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
                        child: Text('Back',
                          style: TextStyle(
                              fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.black,
                              fontFamily: Constants.BUTTON_FONT
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(290, 30)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                  side: BorderSide(color: Colors.black)
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