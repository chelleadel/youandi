import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/gestures.dart';
import 'package:test/constants.dart';
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
        scaffoldBackgroundColor: Colors.white,
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
              style: TextStyle(
                  fontSize: Constants.TITLE_SIZE,
                  fontFamily: Constants.FONT_BASE),
            ),
            SizedBox(height: 5),
            Text(
              "don't forget to check you spams!",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: Constants.FONT_BASE),
            ),
            SizedBox(height: 60),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                controller: _authenController,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '6 Digit Verification',
                  labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(_start.toString()),
            SizedBox(height: 60),
            ElevatedButton(
                onPressed: () {
                  print('digit: ' + _authenController.text);
                  if (_authenController.text == this.validate.toString()) {
                    _timer.cancel();
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
                child: Text('Continue',
                  style: TextStyle(
                    fontSize: Constants.BUTTON_FONT_SIZE,
                    color: Colors.white,
                    fontFamily: Constants.BUTTON_FONT
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
                setState(() {
                  _timer.cancel();
                  _start = 60;
                });
              },
              child: Text('Resend',
                style: TextStyle(
                  fontSize: Constants.BUTTON_FONT_SIZE,
                  color: Colors.black,
                  fontFamily: Constants.BUTTON_FONT
                ),),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Sign_Up()));
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
              builder: (BuildContext context) => SignUpPage()),
        );
      }
    );
  }

}

