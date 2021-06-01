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
        scaffoldBackgroundColor: Colors.yellow.shade100,
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
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
            padding: EdgeInsets.only(left: 16, bottom: 5),
            child: Text(
              "Prompts Page",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Arial',
              ),
            )
        ),
      ),*/
        body: Center(
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70),
                  Text(
                    "Prompt Page",
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'BubblerOne',
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50,),
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
                      child: Text('Update Prompt',
                        style: TextStyle(fontSize: 14, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text('Back',
                        style: TextStyle(fontSize: 14, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
                  ),
                  SizedBox(height: 20,),
                ]
            ),
          )
        ),
      bottomNavigationBar: null,
    );
  }
}