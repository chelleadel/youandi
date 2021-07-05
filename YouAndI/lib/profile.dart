import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/prompts.dart';
import 'package:test/registration.dart';
import 'package:test/services/storage.dart';
import 'package:test/welcomepage.dart';
import 'package:test/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'changepassword.dart';


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
  final _picker = ImagePicker();

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
              child: new SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.0),
                        child: imageProfile(),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${snapshot.data!['DisplayName']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Constants.LABEL_SIZE,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${snapshot.data!['SelfDescription']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Constants.LABEL_SIZE,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        padding: const EdgeInsets.all(10.0),
                        /*decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),*/
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${snapshot.data!['Email']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Constants.LABEL_SIZE,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${snapshot.data!['Gender']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Constants.LABEL_SIZE,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                //"${snapshot.data!['DOB'].toDate()}",
                                "${DateFormat.yMMMd().format(snapshot.data!['DOB'].toDate())}",
                                //overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Constants.LABEL_SIZE,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
                        },
                        child: Text('Change password',
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
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Prompts()));
                        },
                        child: Text('View prompt',
                          style: TextStyle(
                              fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.black,
                              fontFamily: Constants.BUTTON_FONT
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
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Registration(reEnter: true,)));
                        },
                        child: Text('Update details',
                          style: TextStyle(fontSize: Constants.BUTTON_FONT_SIZE,
                              color: Colors.black,
                              fontFamily: Constants.BUTTON_FONT),),
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
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
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
                ),
              )
          ),
        ) :
        Container();
      },
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

  imageProfile() {

    StorageService ss = new StorageService();
    User? user = FirebaseAuth.instance.currentUser;
    String id = "buffer";
    if (user != null) {
      id = user.uid;
    }

    print(id);

    return FutureBuilder(
        future: ss.
        findDisplayPicture(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircleAvatar(
              radius: 80.0,
            );
          } else {
            print(snapshot.data.toString());
            return CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage('${snapshot.data.toString()}'),
            );
          }
        }
    );

  }


}