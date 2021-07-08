import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:test/constants.dart';
import 'package:test/registration.dart';
import 'package:test/sign_up.dart';

import 'package:firebase_auth/firebase_auth.dart';


class ConfirmEmailPage extends StatefulWidget {


  ConfirmEmailPage({Key? key}) : super(key: key);

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPage();

}

class _ConfirmEmailPage extends State<ConfirmEmailPage> {

  // timer
  int _start = 60;
  Timer _timer = new Timer(Duration(seconds: 60), () {
    print("done");
  });

  final database = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    User? user = database.currentUser;

    if (user != null) {
      if (_start == 60) {
        startTimer();
      } else {
        user.reload();
        if (user.emailVerified) {
          _timer.cancel();
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Registration(reEnter: false,))));
          // Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Registration(reEnter: false,)));
        }
      }
    }



    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Constants.BG_BASE,
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Back',
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  FirebaseFirestore.instance.collection('Users').doc(user.uid).delete();
                  user.delete();
                };
                await FirebaseAuth.instance.signOut();
                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Sign_Up()));
              },
            ),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'An email have been sent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Constants.TITLE_SIZE,
                        fontFamily: Constants.FONT_BASE),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Press the link to verify your email",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: Constants.FONT_BASE),
                  ),
                  SizedBox(height: 60),
                  Text(_start.toString()),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () async {

                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null && !user.emailVerified) {
                        await user.sendEmailVerification();
                      }

                      setState(() {
                        _timer.cancel();
                        _start = 60;
                      });
                    },
                    child: Text('Resend',
                      style: TextStyle(
                          fontSize: Constants.BUTTON_FONT_SIZE,
                          color: Colors.black,
                          fontFamily: Constants.BUTTON_FONT
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
            ),
          ),
        )
    );

  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            returnMainPage();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void returnMainPage() {

    AlertDialog alert = AlertDialog(
      title: Text("Exceeded Time Limit"),
      content: Text("Press the screen to return to Sign Up Page"),
      actions: [
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }).then((exit) async {
      _timer.cancel();
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      if (user != null) {
        user.delete();
      }
      FirebaseFirestore.instance.collection('Users').doc(uid).delete();
      await FirebaseAuth.instance.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage()),
      );
    }
    );
  }

}