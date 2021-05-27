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
        scaffoldBackgroundColor: Colors.yellow.shade100,
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
  PickedFile _displayPicture = PickedFile('');
  bool _displayPictureUpdated = false;
  final TextEditingController _displayName = TextEditingController();
  final ImagePicker _picker = ImagePicker();

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
                    'registration',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: imageProfile(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _displayName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Display Name',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _displayName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Self Description',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        if (_displayPictureUpdated == true) {
                          print('Blank for now');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QuestionsMain()),
                          );
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
                      child: Text('next',
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
              "choose Display Photo",
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

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _displayPicture = pickedFile;
      _displayPictureUpdated = true;
    });
  }

  Widget imageProfile() {
    return Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        backgroundImage: //_displayPicture == PickedFile("assets/Demo_Pic.jpg") ?
        //AssetImage("assets/Demo_Pic.jpg") :
        //AssetImage("assets/Demo_Pic.jpg"),
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