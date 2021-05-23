import 'package:flutter/material.dart';
import 'package:test/confirm_email.dart';
import 'package:test/welcomepage.dart';
import 'package:flutter/gestures.dart';

class Sign_Up extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
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
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'sign-up',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 60),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email:',
                        hintText: 'NUS email only (@u.nus.edu)',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _pass1Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password:',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _pass2Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password:',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        print('email: ' + _emailController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Confirm_Email()),
                        );},
                      child: Text('next',
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
                        text: "return to homepage?\n",
                        style: TextStyle(color: Colors.black,),
                        children: [
                          TextSpan(
                            text: 'back',
                            style: TextStyle(color: Colors.black,
                              decoration: TextDecoration.underline,),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePage())),
                          )
                        ]
                    ),
                  )

                ]
            )
        )
    );

  }


}