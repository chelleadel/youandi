import 'package:flutter/material.dart';
import 'package:test/confirm_email.dart';
import 'package:test/constants.dart';
import 'package:test/welcomepage.dart';
import 'package:flutter/gestures.dart';

class Sign_Up extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _formEmailKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: Constants.TITLE_SIZE,
                        fontFamily: Constants.FONT_BASE,
                        fontWeight: FontWeight.bold
                    ),
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
                                  hintText: 'NUS Email Only (@u.nus.edu)',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _pass1Controller,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Password can't be empty";
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _pass2Controller,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Confirm Password can't be empty";
                                  } else if (value != _pass1Controller.text) {
                                    return "Passwords are not the same";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                            ]
                          )
                      )
                  ),

                  SizedBox(height: 45),
                  ElevatedButton(
                      onPressed: () {
                        print('Email: ' + _emailController.text);
                        if ((_formEmailKey.currentState!.validate())) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ConfirmEmailPage(value: _emailController.text)),
                          );
                        }
                        },
                      child: Text('Continue',
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
            )
        )
    );

  }


}