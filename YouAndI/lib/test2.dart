import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/confirm_email.dart';
import 'package:test/constants.dart';
import 'package:test/welcomepage.dart';
import 'package:flutter/gestures.dart';

class Test2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Test2Page(),
    );
  }
}

class Test2Page extends StatefulWidget {
  Test2Page({Key? key}) : super(key: key);

  @override
  State<Test2Page> createState() => _Test2();
}

class _Test2 extends State<Test2Page> {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _formTest2Key = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Test 2',
                    style: TextStyle(
                        fontSize: Constants.TITLE_SIZE,
                        fontFamily: Constants.FONT_BASE,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formTest2Key,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if ((value == null) || (value.isEmpty)) {
                                      return "Email can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Test 2',
                                    labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                                    hintText: 'Testing',
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ]
                          )
                      )
                  ),

                  SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      print('Things to enter: ' + _emailController.text);
                      if ((_formTest2Key.currentState!.validate())) {
                        print("Starting!");
                        print('Things to enter: ' + _emailController.text);

                        addUser("brandon@gmail.com", "DisplayName", _emailController.text);

                        print("Ended");
                      }
                    },
                    child: Text('Create',
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
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      print('Things to enter: ' + _emailController.text);
                      if ((_formTest2Key.currentState!.validate())) {
                        print("Starting!");
                        print('Things to enter: ' + _emailController.text);

                        updateUser("brandon@gmail.com", "DisplayName", _emailController.text);

                        print("Ended");
                      }
                    },
                    child: Text('Update field',
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
                        )
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print('Things to enter: ' + _emailController.text);
                      if ((_formTest2Key.currentState!.validate())) {
                        print("Starting!");
                        print('Things to enter: ' + _emailController.text);

                        updateUser("brandon@gmail.com", "Gender", _emailController.text);

                        print("Ended");
                      }
                    },
                    child: Text('Add field',
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
                        )
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
                    },
                    child: Text('Back',
                      style: TextStyle(
                        fontSize: Constants.BUTTON_FONT_SIZE,
                        color: Colors.black,
                        fontFamily: Constants.BUTTON_FONT,
                      ),
                    ),
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
    );

  }

  Future<void> addUser(String userId, String key, String item) {
    return users
        .doc(userId)
        .set({
      key: item,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String userId, String key, String item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

}