import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/question15.dart';
import 'package:test/question2.dart';
import 'firebase.dart';

// Q1- I am looking for; 1- Romantic R/S, 2- Friendship, 3- Both
class Question1 extends StatelessWidget {
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
                        'I am looking for',
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q1", 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question15()),
                          );
                        },
                        child: Text('Romantic Relationship',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT
                          ),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                  // side: BorderSide(color: Colors.black)
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q1", 2);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question15()),
                          );
                        },
                        child: Text('Friendship',
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
                                  // side: BorderSide(color: Colors.black)
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q1", 3);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question15()),
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
                                  // side: BorderSide(color: Colors.black)
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