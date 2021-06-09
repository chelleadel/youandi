import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/sign_in.dart';
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 200),
                imageProfile(),
                SizedBox(height: 180),
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
                                child: Text('Sign Up',
                                  style: TextStyle(
                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                    color: Colors.white,
                                    fontFamily: Constants.BUTTON_FONT,
                                  ),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                                    fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
                                          //side: BorderSide(color: Colors.black)
                                        )
                                    ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignInPage()),
                                  );

                                },
                                child: Text('Log In',
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
                ),
                SizedBox(height: 50)
              ]
        )
      )
    );
  }

  Widget imageProfile() {
    return Stack(children: <Widget>[
      CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/spirit.png")),
    ],);
  }

}

