//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/chat.dart';
import 'package:test/questionsmain.dart';
import 'package:test/welcomepage.dart';


class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  PickedFile _displayPicture = PickedFile('');
  bool _displayPictureUpdated = false;
  final TextEditingController _displayName = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  //final TextEditingController _displayPicture = TextEditingController();
  final TextEditingController _selfDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text("Profile"),
      ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: imageProfile(),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _displayName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Change Display Name',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _selfDescription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Change Self Description',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuestionsMain()),
                        );
                        },
                      child: Text('Update prompt',
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomePage()),
                        );
                      },
                      child: Text('Log-out',
                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(145, 50),
                        primary: Colors.cyanAccent.shade100,
                      )
                  ),
                ]
            )
        ),
      bottomSheet: bottomSheetForMain(),
    );
  }

  Widget bottomSheetForMain() {
    return Container(
      //color: Colors.cyan,
      height: 48.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()),
              );
            },
            icon: Icon(
              Icons.list,
              color: Colors.blue,
            ),
            label: Text(
              "Chat",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            label: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
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