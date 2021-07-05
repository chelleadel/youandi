import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/sign_in.dart';
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 200),
                imageProfile(),
                SizedBox(height: 160),
                Form(
                    key: _formEmailKey,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Sign_Up()),
                                  );
                                },
                                child: Text('SIGN UP',
                                  style: TextStyle(
                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                    color: Colors.black,
                                    fontFamily: Constants.BUTTON_FONT,
                                  ),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                                    fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                          side: BorderSide(color: Colors.black)
                                        )
                                    ),
                                ),
                              ),
                              SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignInPage()),
                                  );
                                },
                                child: Text('LOG IN',
                                  style: TextStyle(
                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                    color: Colors.black,
                                    fontFamily: Constants.BUTTON_FONT,
                                  ),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Constants.BG_BASE),
                                    fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                          side: BorderSide(color: Colors.black)
                                        )
                                    ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ]
                        ),
                    ),
                ),
                SizedBox(height: 70)
              ]
        )
      )
    );
  }

  Widget imageProfile() {
    return Stack(
      children: <Widget> [
        CircleAvatar(
          radius: 120.0,
          backgroundImage: AssetImage("assets/finalogo.png"),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

}

