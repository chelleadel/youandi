import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/questionsmain.dart';
import 'package:test/registration.dart';
import 'package:test/services/firebase.dart';
import 'package:test/sign_up.dart';
import 'package:test/test.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';

import 'forgetpassword.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {

  final _formEmailKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BG_BASE,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => WelcomePage()));
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign In',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Constants.TITLE_SIZE,
                    fontFamily: Constants.FONT_BASE,
                    fontWeight: FontWeight.bold,
                  )
              ),
              SizedBox(height: 40),
              Form(
                  key: _formEmailKey,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Email can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                            SizedBox(height: 10),

                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Password can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            )
                          ]
                      )
                  )
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  bool loginSuccess = false;
                  bool warnedUserOver = false; // true if the warningCounter is 3 or more
                  String error = "None";
                  if (_formEmailKey.currentState!.validate()) {

                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                      loginSuccess = true;
                      User? user = FirebaseAuth.instance.currentUser;
                      print(!user!.emailVerified);
                      print(user != null);

                      DocumentSnapshot ds = await Firebase.GET_USER(user.uid);
                      int warningCounter = ds.get("warningCounter");
                      if (warningCounter >= 3) {
                        await FirebaseAuth.instance.signOut();
                        warnedUserOver = true;
                      }

                      if (user!= null && !user.emailVerified) {
                        await user.sendEmailVerification();
                        loginSuccess = false;
                      }

                      if (user != null && user.emailVerified) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user.uid)
                            .get()
                            .then((DocumentSnapshot documentSnapshot) {
                          if (documentSnapshot.exists) {
                            bool error = false;
                            try {
                              dynamic nested = documentSnapshot.get(FieldPath(['DisplayName']));
                            } on StateError catch(e) {
                              error = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Registration(reEnter: false)),
                              );
                            }

                            try {
                              dynamic nested = documentSnapshot.get(FieldPath(['Q3']));
                            } on StateError catch(e) {
                              if (error == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionsMain()),
                                );
                              }
                            }
                          }
                        });
                      }

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        error = 'User not found';
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        error = 'Wrong password';
                      }
                    }
                  }
                  if (loginSuccess && !warnedUserOver) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else if (warnedUserOver) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("User is suspended"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('You have been reported. Breached Maximum Warnings'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => WelcomePage()),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                    );
                  } else if (error == "User not found") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("User not found"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Please try again'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  }
                  else if (error == "Wrong password") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Wrong password"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Please try again'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Email is not verified!"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('A verification email has just been sent to your registered email address.'),
                                  Text('Kindly verify'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  }
                },
                child: Text('Continue',
                  style: TextStyle(
                    fontSize: Constants.BUTTON_FONT_SIZE,
                    color: Colors.black,
                    fontFamily: Constants.BUTTON_FONT,
                  ),
                ),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                  );
                },
                child: Text('Forget password',
                  style: TextStyle(
                    fontSize: Constants.BUTTON_FONT_SIZE,
                    color: Colors.black,
                    fontFamily: Constants.BUTTON_FONT,
                  ),
                ),
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
    );
  }
}

