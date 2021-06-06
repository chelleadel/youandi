//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/homepage.dart';
import 'package:test/question1.dart';
import 'package:test/question2.dart';
import 'package:test/question3.dart';
import 'package:test/questionsmain.dart';


class Prompts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow[50],
      ),
      home: PromptsPage(),
    );
  }
}

class PromptsPage extends StatefulWidget {
  PromptsPage({Key? key}) : super(key: key);

  @override
  State<PromptsPage> createState() => _PromptsPage();
}

class _PromptsPage extends State<PromptsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: false,
        title: Padding(
            padding: EdgeInsets.only(left: 16, bottom: 5),
            child: Text(
              "Prompts",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      ),
        body: Center(
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question 1',
                    style: TextStyle(fontSize: 48,
                      fontFamily: 'BubblerOne',
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Favorite singaporean food?',
                    style: TextStyle(fontSize: 20,
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'User answer for question 1',
                    style: TextStyle(fontSize: 16,
                      fontFamily: 'BubblerOne',
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Question 2',
                    style: TextStyle(fontSize: 48,
                      fontFamily: 'BubblerOne',
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Favorite singaporean food?',
                    style: TextStyle(fontSize: 20,
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'User answer for question 2',
                    style: TextStyle(fontSize: 16,
                      fontFamily: 'BubblerOne',
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Question 3',
                    style: TextStyle(fontSize: 48,
                      fontFamily: 'BubblerOne',
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Favorite singaporean food?',
                    style: TextStyle(fontSize: 20,
                      color: Colors.black,),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'User answer for question 3',
                    style: TextStyle(fontSize: 16,
                      fontFamily: 'BubblerOne',
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,),
                  ),
                  SizedBox(height: 50,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionsMain()),
                      );
                    },
                    child: Text('Update prompts',
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
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
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
                  SizedBox(height: 10),
                  SizedBox(height: 20,),
                ]
            ),
          )
        ),
      bottomNavigationBar: null,
    );
  }
}