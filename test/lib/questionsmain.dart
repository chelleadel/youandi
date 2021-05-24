import 'package:flutter/material.dart';
import 'package:test/question1.dart';

class QuestionsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        'questions',
                        style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne', color: Colors.black,),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'a series of questions will\n be asked to ',
                        style: TextStyle(fontSize: 30, fontFamily: 'BubblerOne', color: Colors.black,),
                          children: [
                            TextSpan(
                              text: 'find your\nperfect partner',
                              style: TextStyle(fontSize: 30, fontFamily: 'BubblerOne', color: Colors.black, decoration: TextDecoration.underline,),
                            )
                          ]
                      )
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Question1()),
                          );
                        },
                        child: Text('start',
                          style: TextStyle(fontSize: 16, color: Colors.black,),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(145, 50),
                          primary: Colors.cyanAccent.shade100,
                        )
                    ),
                  ]
              )
            )
        )
    );
  }
}