import 'package:flutter/material.dart';
import 'package:test/question1.dart';

class QuestionsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.yellow[50],
        ),
        home: Scaffold(
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'A series of questions will be asked to help find your perfect partner!',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'BubblerOne',
                          color: Colors.black,

                        ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Question1()),
                        );
                      },
                      child: Text('Next',
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
                  ]
              )
            )
        )
    );
  }
}