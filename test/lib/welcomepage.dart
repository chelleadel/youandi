import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test/homepage.dart';
import 'package:test/sign_up.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {

  final _formEmailKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('YOU&I',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne')
                ),
                Text('creating lifelong connections',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 130),
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
                                  border: OutlineInputBorder(),
                                  labelText: 'Email:',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                              SizedBox(height: 25),

                              TextFormField(
                                validator: (value) {
                                  if ((value == null) || (value.isEmpty)) {
                                    return "Password can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password:',
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              )
                            ]
                        )
                    )
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (_formEmailKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text('Log in',
                      style: TextStyle(fontSize: 16, color: Colors.black,),),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(145, 50),
                      primary: Colors.cyanAccent.shade100,
                    )
                ),
                SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Don't have an\naccount? Sign in ",
                      style: TextStyle(color: Colors.black,),
                      children: [
                        TextSpan(
                          text: 'here',
                          style: TextStyle(color: Colors.black,
                            decoration: TextDecoration.underline,),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign_Up())),
                        )
                      ]
                  ),
                )
              ]
          ),
      ),
    );
  }
}

