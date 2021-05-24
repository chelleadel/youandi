import 'package:flutter/material.dart';
import 'package:test/question1.dart';
import 'package:test/question3.dart';

class Question2 extends StatelessWidget {

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
                        'question 2',
                        style: TextStyle(fontSize: 48,
                          fontFamily: 'BubblerOne',
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'favorite singaporean food',
                        style: TextStyle(fontSize: 20, color: Colors.black,),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Question3()),
                            );
                          },
                          child: Text('durian',
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
                              MaterialPageRoute(builder: (context) => Question3()),
                            );
                          },
                          child: Text('chicken rice',
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
                              MaterialPageRoute(builder: (context) => Question3()),
                            );
                          },
                          child: Text('mala',
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
                              MaterialPageRoute(builder: (context) => Question3()),
                            );
                          },
                          child: Text('fish soup',
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
                              MaterialPageRoute(builder: (context) => Question3()),
                            );
                          },
                          child: Text('laksa',
                            style: TextStyle(
                              fontSize: 16, color: Colors.black,),),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(299, 48),
                            primary: Colors.cyanAccent.shade100,
                          )
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Question1()),
                            );
                          },
                          child: Text('back',
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