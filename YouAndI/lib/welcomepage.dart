import 'package:flutter/material.dart';
import 'package:test/homepage.dart';
import 'package:test/sign_up.dart';
import 'package:test/test.dart';

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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('YOU&I',
                    style: TextStyle(fontSize: 60, fontFamily: 'BubblerOne')
                ),
                Text('creating lifelong connections',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 125),
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
                    child: Text('Log in',
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
                      MaterialPageRoute(builder: (context) => Sign_Up()),
                    );
                  },
                  child: Text('Sign up',
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
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Test()),
                    );
                  },
                  child: Text('Test site',
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
          ),
      ),
    );
  }
}

