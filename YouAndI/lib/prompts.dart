//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/homepage.dart';
import 'package:test/question1.dart';
import 'package:test/question2.dart';
import 'package:test/question3.dart';
import 'package:test/questionsmain.dart';
import 'package:test/constants.dart';


class Prompts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.BG_BASE,
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

  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot
                .hasError
                .toString()),
          );
        return snapshot.hasData ?
        Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.BG_BASE,
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
                        style: TextStyle(fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'I am looking for: ',
                        style: TextStyle(fontSize: Constants.LABEL_SIZE,
                          fontFamily: Constants.FONT_PROMPT,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        determineQ1(snapshot.data!['Q1']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Constants.LABEL_SIZE,
                            color: Constants.PROMPT_ANS,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text(
                        'Question 2',
                        style: TextStyle(fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Pair me with a: ',
                        style: TextStyle(fontSize: Constants.LABEL_SIZE,
                          fontFamily: Constants.FONT_PROMPT,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        determineQ2(snapshot.data!['Q2']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Constants.LABEL_SIZE,
                          color: Constants.PROMPT_ANS,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text(
                        'Question 3',
                        style: TextStyle(fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Age Preference: ',
                        style: TextStyle(fontSize: Constants.LABEL_SIZE,
                          fontFamily: Constants.FONT_PROMPT,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        determineQ3(snapshot.data!['LowerAgePreference'], snapshot.data!['UpperAgePreference']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Constants.LABEL_SIZE,
                          color: Constants.PROMPT_ANS,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text(
                        'Question 4',
                        style: TextStyle(fontSize: Constants.TITLE_SIZE,
                          fontFamily: Constants.FONT_BASE,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'My perfect day: ',
                        style: TextStyle(fontSize: Constants.LABEL_SIZE,
                          fontFamily: Constants.FONT_PROMPT,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        determineQ4(snapshot.data!['Q3']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Constants.LABEL_SIZE,
                          color: Constants.PROMPT_ANS,
                        ),
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
                            backgroundColor: MaterialStateProperty.all<Color>(Constants.BUTTON_BASE),
                            fixedSize: MaterialStateProperty.all<Size>(Size(Constants.BORDER_WIDTH, Constants.BORDER_HEIGHT)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Constants.BORDER_RADIUS),
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
                            )
                        ),
                      ),
                      SizedBox(height: 30,),
                    ]
                ),
              )
          ),
          bottomNavigationBar: null,
        ) :
        Container();
      },

    );
  }

  String determineQ1(int int) {
    if (int == 1) {return "Romantic relationship";}
    else if (int == 2) {return "Friendship";}
    else {return "Both romantic relationship & friendship";}
  }

  String determineQ2(int int) {
    if (int == 1) {return "Female";}
    else if (int == 2) {return "Male";}
    else {return "Both male and female";}
  }

  String determineQ3(int lowerAge, int upperAge) {
    return "" + lowerAge.toString() + " - " + upperAge.toString() + " years old";
  }

  String determineQ4(int int) {
    if (int == 1) {return "Chilling at home";}
    else if (int == 2) {return "Going for a food trip";}
    else if (int == 3) {return "Going for shopping";}
    else if (int == 4) {return "Visiting tourist attractions";}
    else {return "Doing physical activities";}
  }

}