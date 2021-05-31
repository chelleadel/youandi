import 'package:flutter/material.dart';
import 'package:test/question15.dart';
import 'package:test/question2.dart';

class Question1 extends StatelessWidget {

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
                        'I am looking for',
                        style: TextStyle(fontSize: 48,
                          fontFamily: 'BubblerOne',
                          color: Colors.black,),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Question15()),
                            );
                          },
                          child: Text('romantic relationship',
                            style: TextStyle(
                              fontSize: 16, color: Colors.black,),),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(299, 48),
                            primary: Colors.cyanAccent.shade100,
                          )
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Question15()),
                            );
                          },
                          child: Text('friendship',
                            style: TextStyle(
                              fontSize: 16, color: Colors.black,),),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(299, 48),
                            primary: Colors.cyanAccent.shade100,
                          )
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Question15()),
                            );
                          },
                          child: Text('both',
                            style: TextStyle(
                              fontSize: 16, color: Colors.black,),),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(299, 48),
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