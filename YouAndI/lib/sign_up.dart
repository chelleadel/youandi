import 'package:flutter/material.dart';
import 'package:test/confirm_email.dart';
import 'package:test/welcomepage.dart';
import 'package:flutter/gestures.dart';

class Sign_Up extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow[50],
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
                    'Sign-up',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 60),
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
                                  border: OutlineInputBorder(),
                                  labelText: 'Email:',
                                  hintText: 'NUS Email Only (@u.nus.edu)',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 25),
                              TextFormField(
                                controller: _pass1Controller,
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Password can't be empty";
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password:',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 25),
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
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirm Password:',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                            ]
                          )
                      )
                  ),

                  SizedBox(height: 30),
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
                      child: Text('Next',
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
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
                    },
                    child: Text('Back',
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
    );

  }


}