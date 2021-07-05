import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/question1.dart';

class QuestionsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Scaffold(
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Tell me about\nyourself',
                        style: TextStyle(
                          fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,
                          fontWeight: FontWeight.bold

                        ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Question1()),
                        );
                      },
                      child: Text('Begin',
                        style: TextStyle(
                          fontSize:Constants.BUTTON_FONT_SIZE,
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
                          )
                      ),
                    ),
                  ]
              )
            )
        )
    );
  }
}