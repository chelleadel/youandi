import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/profile.dart';
import 'package:test/sign_up.dart';
import 'package:test/test.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formEmailKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _passwordControllerOld = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Change Password',
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
                                } else if (!(value.contains('@u.nus.edu'))) {
                                  return "NUS Email required";
                                  } else if (value != currentUser!.email) {
                                  return "Not the same email address";
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
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _passwordControllerOld,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Password can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: ' Old Password',
                                labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _passwordController1,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Password can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'New password',
                                labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _passwordController2,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Password can't be empty";
                                } else if (value != _passwordController1.text) {
                                  return "Passwords are not the same";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'New password',
                                labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                          ]
                      )
                  )
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () async {
                  if ((_formEmailKey.currentState!.validate())) {
                    bool reLogInSuccess = false;
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordControllerOld.text
                      );
                      reLogInSuccess = true;
                      User? user = FirebaseAuth.instance.currentUser;
                      user!.updatePassword(_passwordController1.text).then((_){
                        print("Successfully changed password");
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Password successfully changed!"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Profile()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      }).catchError((error){
                        print("Password can't be changed" + error.toString());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Please try again later.'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Profile()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                      });

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('No user found!'),
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
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Wrong password.'),
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
                    }
                  }
                },
                child: Text('Continue',
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                child: Text('Back',
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

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

