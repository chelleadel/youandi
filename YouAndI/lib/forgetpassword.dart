import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/sign_up.dart';
import 'package:test/test.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formEmailKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Forget Password',
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
                          ]
                      )
                  )
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  if ((_formEmailKey.currentState!.validate())) {
                    resetPassword(_emailController.text);

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Check your registered email"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('An email has just been sent to your registered email address to change your password.'),
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
                                    MaterialPageRoute(builder: (context) => WelcomePage()),
                                  );
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
                    MaterialPageRoute(builder: (context) => WelcomePage()),
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

