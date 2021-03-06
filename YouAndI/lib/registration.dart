import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:test/questionsmain.dart';
import 'package:test/services/storage.dart';

import 'services/firebase.dart';

class Registration extends StatelessWidget {
  bool reEnter;
  Registration({required this.reEnter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RegistrationPage(reEnter: reEnter,),
    );
  }
}

class RegistrationPage extends StatefulWidget {

  bool reEnter;
  RegistrationPage({required this.reEnter});

  @override
  State<RegistrationPage> createState() => _RegistrationPage(reEnter: reEnter);
}

class _RegistrationPage extends State<RegistrationPage> {

  bool reEnter;
  _RegistrationPage({required this.reEnter});

  final _formNameKey = GlobalKey<FormState>();
  final _formSelfDescriptionKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;

  String _displayPicture = "https://cdn.asiatatler.com/asiatatler/i/hk/2021/04/23123235-image-11_cover_1024x1024.png";
  
  bool _displayPictureUpdated = false;
  final TextEditingController _displayName = TextEditingController();
  final _picker = ImagePicker();

  //final TextEditingController _displayPicture = TextEditingController();
  final TextEditingController _selfDescription = TextEditingController();
  String dropdownValueGender = 'Choose';
  String dropdownValueAge = 'Choose';
  DateTime _dateOfBirth = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(
                        fontSize: Constants.TITLE_SIZE,
                        fontFamily: Constants.FONT_BASE,
                        // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: imageProfile(),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formNameKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        validator: (value) {
                          if ((value == null) || (value.isEmpty)) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                        controller: _displayName,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Display name',
                          labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Form(
                    key: _formSelfDescriptionKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextFormField(
                        validator: (value) {
                          if ((value == null) || (value.isEmpty)) {
                            return "Self description can't be empty";
                          } else {
                            return null;
                          }
                        },
                        controller: _selfDescription,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Self description',
                          labelStyle: TextStyle(fontSize: Constants.LABEL_SIZE),
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 16,),
                        Text(
                          "Gender:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 20,),
                        DropdownButton<String>(
                          value: dropdownValueGender,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueGender = newValue!;
                              print('ss ' + _displayPicture);
                            });
                          },
                          items: <String>['Choose', 'Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 16,),
                        Text(
                          "DOB:",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 34,),
                        ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now()
                              ).then((date) {
                                setState(() {
                                  if (date != null) {
                                    _dateOfBirth = date;
                                  }
                                });
                              }
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              "${_dateOfBirth.day}-${_dateOfBirth.month}-${_dateOfBirth.year}",
                              style: TextStyle(color: Colors.black),
                            ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        if (_displayPictureUpdated == true) {
                          if (dropdownValueGender != "Choose") {
                            if (_dateOfBirth != DateTime.now()) {
                              if (_formNameKey.currentState!.validate() &&
                                  _formSelfDescriptionKey.currentState!
                                      .validate()) {
                                Firebase.UPDATE_USER_STRING(currentUser!.uid, "DisplayName", _displayName.text);
                                Firebase.UPDATE_USER_STRING(currentUser!.uid, "SelfDescription", _selfDescription.text);
                                Firebase.UPDATE_USER_STRING(currentUser!.uid, "Gender", dropdownValueGender);
                                Firebase.UPDATE_USER_TIME(currentUser!.uid, "DOB", _dateOfBirth);

                                print("ReEnter status: ");
                                print(reEnter);
                                if (reEnter == true) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                }
                                else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuestionsMain()),
                                  );
                                }
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Please select your age"),
                                    );
                                  });
                            }
                          }
                          else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Please choose your gender"),
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Please choose a display picture"),
                                );
                              });
                        };
                        },
                      child: Text('Next',
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
                  )
                ]
            )
        )
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
              "Choose display photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      )
      );
  }

  Future takePhoto(ImageSource source) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = "buffer";
    if (user != null){
      uid = user.uid;
    }

    final _storage = FirebaseStorage.instance;
    final pickedFile = await _picker.getImage(source: source);
    StorageService ss = new StorageService();

    if (pickedFile != null){

      if (_displayPictureUpdated) {
        // delete the existing data!
        await _storage
            .ref()
            .child('displayPictures/${uid}')
            .delete();
      }

      //Upload to Firebase
      await _storage
          .ref()
          .child('displayPictures/${uid}')
          .putFile(File(pickedFile.path));

      String downUrl = await ss.findDisplayPicture(uid);

      setState(() {
        _displayPictureUpdated = true;
        _displayPicture = downUrl;
      });

    } else {
      print('No Path Received');
    }
  }

  checkExistingPicture() async {

    User? user = FirebaseAuth.instance.currentUser;
    String uid = "buffer";
    if (user != null){
      uid = user.uid;
    }

    String existedPicture = await FirebaseStorage.instance
              .ref('displayPictures/${uid}')
              .getDownloadURL();

    if (existedPicture.isNotEmpty) {
      _displayPictureUpdated = true;
      _displayPicture = existedPicture;

    }
  }

  Widget imageProfile() {

    checkExistingPicture();

    return Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        backgroundImage: NetworkImage(_displayPicture),
      ),
      Positioned(
        bottom: 20.0,
      right: 20.0,
        child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
          );
        },
        child:
      Icon(Icons.camera_alt,
        color: Colors.cyanAccent,
        size: 28.0,),
        ),
      )
    ],);
  }

}