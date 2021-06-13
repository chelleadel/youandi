//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/constants.dart';
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
  String dropdownValueGender = 'Choose';
  String dropdownValueAge = 'Choose';

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
                  SizedBox(height: 10,),
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
                  SizedBox(height: 15,),
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
                          "Age:",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 34,),
                        DropdownButton<String>(
                          value: dropdownValueAge,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueAge = newValue!;
                            });
                          },
                          items: <String>['Choose', '15', '16', '17', '18', '19', '20', '21'
                            , '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'
                            ,'32', '33', '34', '35']
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
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        if (_displayPictureUpdated == true) {
                          if (dropdownValueGender != "Choose") {
                            if (dropdownValueAge != "Choose") {
                              if (_formNameKey.currentState!.validate() &&
                                  _formSelfDescriptionKey.currentState!
                                      .validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionsMain()),
                                );
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