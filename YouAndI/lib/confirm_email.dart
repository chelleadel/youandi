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
        scaffoldBackgroundColor: Colors.yellow[50],
    ),
    home: Scaffold(
      resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the verification code which was sent to your registered email address',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontFamily: 'BubblerOne'),
            ),
            SizedBox(height: 5),
            Text(
              "don't forget to check you spams!",
              style: TextStyle(fontSize: 25, fontFamily: 'BubblerOne'),
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
            SizedBox(height: 60),
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
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timer.cancel();
                  _start = 60;
                });
              },
              child: Text('Resend code',
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
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Sign_Up()));
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
      ),
    ),
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
              builder: (BuildContext context) => Registration()),
        );
      }
    );
  }

}

