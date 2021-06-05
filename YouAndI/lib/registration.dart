//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/questionsmain.dart';

class Registration extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final _formNameKey = GlobalKey<FormState>();
  final _formSelfDescriptionKey = GlobalKey<FormState>();

  File _displayPicture = File("assets/Demo_Pic.jpg");
  
  bool _displayPictureUpdated = false;
  final TextEditingController _displayName = TextEditingController();
  final _picker = ImagePicker();

  //final TextEditingController _displayPicture = TextEditingController();
  final TextEditingController _selfDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: imageProfile(),
                  ),
                  SizedBox(height: 10),
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
                          border: OutlineInputBorder(),
                          labelText: 'Display name',
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          border: OutlineInputBorder(),
                          labelText: 'Self description',
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        if (_displayPictureUpdated == true) {
                          if (_formNameKey.currentState!.validate() && _formSelfDescriptionKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuestionsMain()),
                            );
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
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
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
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _displayPictureUpdated = true;
        _displayPicture = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget imageProfile() {
    return Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        backgroundImage: _displayPictureUpdated == false ?
        FileImage(File("assets/Demo_Pic.jpg")) :
        FileImage(File(_displayPicture.path)),
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