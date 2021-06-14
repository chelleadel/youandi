import 'package:flutter/material.dart';
import 'package:test/chatusers.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:test/userdetail.dart';

class ChatDetailPage extends StatefulWidget{

  final ChatUsers user;

  ChatDetailPage({required this.user});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(partner: user);
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  final ChatUsers partner;

  _ChatDetailPageState({required this.partner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.yellow[50],
            ),
            centerTitle: false,
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Chat Page',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(partner.imageURL),
                    maxRadius: 25,
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          partner.name,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 20,
                              color: Colors.black
                          )
                      ),
                      Text(
                          partner.time,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 15,
                              color: Colors.grey[800]
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: Constants.BG_BASE,
            actions: <Widget>[
              IconButton(
                color: Colors.black,
                icon: const Icon(Icons.report_problem_rounded),
                tooltip: 'Report user',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("User reported!"),
                        );
                      }
                  );
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => UserDetailMain(user: partner,)));
          },
        ),
        body: Scaffold(
          body: ChatBody(),
        ),
        bottomNavigationBar: BottomBar(),
    );
  }

}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  CustomAppBar({Key? key, required this.onTap, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(onTap: onTap,child: appBar);
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class ChatBody extends StatefulWidget {

  const ChatBody({Key? key}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ]
      )
    );
  }

}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  final _picker = ImagePicker();
  bool _sentPictureUpdated = false;
  File _sentPicture = File("assets/Demo_Pic.jpg");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Column(
        children: [
          Row(
              children: [
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            icon: Icon(Icons.photo_camera),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Type here",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                SizedBox(width: 15,),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Constants.CHAT_BASE_DARK,
                      shape: BoxShape.circle
                  ),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                )
              ]
          ),
          SizedBox(height: 10)
        ],
      )
    );
  }

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _sentPictureUpdated = true;
        _sentPicture = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
              "Send Image",
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

}
