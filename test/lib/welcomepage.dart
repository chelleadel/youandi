import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test/sign_up.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email:',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password:',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    print('email: ' + _emailController.text);
                  },
                  child: Text('log in',
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