import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/sign_up.dart';
import 'package:test/test.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {

  final _formEmailKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Password can't be empty";
                                } else {
                                  return null;
                                }
                              },
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
                onPressed: () {
                  if (_formEmailKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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
              SizedBox(height: 10),
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
}

