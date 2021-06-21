import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/homepage.dart';
import 'package:test/question15.dart';
import 'package:test/question3.dart';
import 'package:test/constants.dart';

import 'firebase.dart';

// Q3- My perfect day; [1- Chilling at home, 2- Going for a food trip, 3- Going for shopping,
// 4- Visiting tourist attractions, 5- Doing physical activities]
class Question2 extends StatelessWidget {
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
                        'My perfect day',
                        textAlign: TextAlign.center,
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q3", 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Chilling at home',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT,
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q3", 2);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Going for a food trip',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT,
                          ),),
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q3", 3);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Going for shopping',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT,
                          ),),
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q3", 4);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Visiting tourist attractions',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT,
                          ),),
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
                          Firebase.UPDATE_USER_INT(currentUser!.uid, "Q3", 5);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Doing physical activities',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT,
                          ),),
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
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                        child: Text('Back',
                          style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.black,
                            fontFamily: Constants.BUTTON_FONT,
                          ),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
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