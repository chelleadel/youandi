import 'package:firebase_auth/firebase_auth.dart';
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

  var currentUser = FirebaseAuth.instance.currentUser;


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

    return MaterialApp(
        theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
    ),
    home: Scaffold(
      resizeToAvoidBottomInset: false,
        body:
      Text(
        'Registration',
        style: TextStyle(
          fontSize: Constants.TITLE_SIZE,
          fontFamily: Constants.FONT_BASE,
          // fontWeight: FontWeight.bold,
        ),
      ),
    )
    );

  }









}

