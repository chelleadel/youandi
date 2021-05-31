import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/gestures.dart';
import 'package:test/registration.dart';
import 'package:test/sign_up.dart';


class ConfirmEmailPage extends StatefulWidget {

  final String value;

  ConfirmEmailPage({Key? key, required this.value}) : super(key: key);

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPage(recipient: value);

}

class _ConfirmEmailPage extends State<ConfirmEmailPage> {

  final String username = "youandi-main@outlook.com";

  final smtpServer = hotmail("youandi-main@outlook.com","1605youandi1993");

  final String recipient;
  final String subject = "Please verify your account";
  final TextEditingController _authenController = TextEditingController();

  // random number generator
  int validate = 100000 + new Random().nextInt(999999 - 100000);

  // timer
  int _start = 60;
  Timer _timer = new Timer(Duration(seconds: 60), () {
    print("done");
  });


  _ConfirmEmailPage({required this.recipient}) : super();

  @override
  Widget build(BuildContext context) {

    if (_start == 60) {
      sendEmail();
      startTimer();
    }



    return MaterialApp(
        theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
    ),
    home: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'An email has been sent\nto your registered\nemail! kindly verify\nbefore proceeding.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "don't forget to check you spams!",
                    style: TextStyle(fontSize: 28, fontFamily: 'BubblerOne'),
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
                              ..onTap = () => setState(() {
                                _timer.cancel();
                                _start = 60;
                              })
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
                  SizedBox(height: 5),
                  Text(_start.toString()),
                  SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () {
                        print('digit: ' + _authenController.text);
                        if (_authenController.text == this.validate.toString()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        } else {
                          showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Incorrect Number! Try Again"),
                            );
                          });
                        }
                      },
                      child: Text('Ok',
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
                      child: Text('Back',
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.grey.shade400,
                      )
                  ),
                ]
            )
        )
    )
    );

  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            print("repeat");
            timer.cancel();
            returnMainPage();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void sendEmail() {
    Message message = Message()
      ..from = Address(this.username)
      ..recipients.add(this.recipient)
      ..subject = this.subject
      ..text = validate.toString();

    try {
      final sendReport = send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void returnMainPage() {

    AlertDialog alert = AlertDialog(
      title: Text("Exceeded Time Limit"),
      content: Text("Press the screen to return to Sign Up Page"),
      actions: [
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
    }).then((exit) {
        _timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Sign_Up()),
        );
      }
    );
  }

}

