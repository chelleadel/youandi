import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:test/questionsmain.dart';
import 'package:test/sign_up.dart';


class Confirm_Email extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
      ),
      home: ConfirmEmailPage(),
    );
  }
}

class ConfirmEmailPage extends StatefulWidget {
  ConfirmEmailPage({Key? key}) : super(key: key);

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPage();

}

class _ConfirmEmailPage extends State<ConfirmEmailPage> {

  final TextEditingController _authenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'an email has been sent\nto your registered\nemail! kindly verify\nbefore proceeding.',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Did not receive the email? Click\nhere to ",
                        style: TextStyle(color: Colors.black,),
                        children: [
                          TextSpan(
                            text: 'resend',
                            style: TextStyle(color: Colors.black,
                              decoration: TextDecoration.underline,),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print("resend"),
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _authenController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '6 Digit Verification:',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        print('digit: ' + _authenController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuestionsMain()),
                        );
                      },
                      child: Text('ok',
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        print('digit: ' + _authenController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Sign_Up()),
                        );
                        },
                      child: Text('back',
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.grey.shade400,
                      )
                  ),
                ]
            )
        )
    );
  }
}