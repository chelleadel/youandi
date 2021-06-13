//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/chat.dart';
import 'package:test/prompts.dart';
import 'package:test/questionsmain.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.BG_BASE,
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

  File _displayPicture = File("assets/Demo_Pic.jpg");
  bool _displayPictureUpdated = false;
  final TextEditingController _displayName = TextEditingController();
  final _picker = ImagePicker();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Users').snapshots();
  var _testing;

  //final TextEditingController _displayPicture = TextEditingController();
  final TextEditingController _selfDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BG_BASE,
        centerTitle: false,
        title: Padding(
            padding: EdgeInsets.only(left: 16, bottom: 5),
            child: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Constants.HEADER_SIZE,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: imageProfile(),
                  ),
                  SizedBox(height: 40,),

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
                          "Display Name:",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 10,),
                        StreamBuilder<QuerySnapshot>(
                          stream: _usersStream,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              return new Text(data['DisplayName']);
                            });

                            return new Text("Error");

                            /*return new ListView(
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                return new ListTile(
                                  title: new Text(data['DisplayName']),
                                  subtitle: new Text(data['Gender']),
                                );
                              }).toList(),
                            );*/
                          },
                        )
                      ],
                    ),
                  ),



                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextFormField(
                      controller: _displayName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Change display name',
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
                        labelText: 'Change self description',
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 55,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Prompts()));
                        },
                      child: Text('View prompt',
                        style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Details updated!"),
                              );
                            });
                      },
                      child: Text('Update details',
                        style: TextStyle(fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.white,
                            fontFamily: Constants.BUTTON_FONT),),
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
                        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => WelcomePage()));
                      },
                      child: Text('Log out',
                        style: TextStyle(
                            fontSize: Constants.BUTTON_FONT_SIZE,
                            color: Colors.black,
                            fontFamily: Constants.BUTTON_FONT
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
                ]
            )
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

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _displayPicture = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget imageProfile() {
    return Stack(children: <Widget>[
      CircleAvatar(
        radius: 90.0,
        // backgroundImage: //_displayPicture == PickedFile("assets/Demo_Pic.jpg") ?
        //AssetImage("assets/Demo_Pic.jpg") :
        //AssetImage("assets/Demo_Pic.jpg"),
        ///FileImage(File(_displayPicture.path)),
        // _displayPicture == null ?
        // FileImage(File("assets/Demo_Pic.jpg")) :
        // FileImage(File(_displayPicture.path))
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
    size: 20.0,),
        ),
      )
    ],);
  }


}