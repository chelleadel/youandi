import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/models/chatusers.dart';
import 'package:test/constants.dart';
import 'package:test/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/services/firebase.dart';
import 'package:test/services/storage.dart';

import 'dart:io';

import 'package:test/userdetail.dart';

class ChatDetailPage extends StatefulWidget{

  String userId;
  String partnerId;
  String chatId;

  ChatDetailPage({required this.userId, required this.partnerId, required this.chatId});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(userId: userId, partnerId: partnerId, chatId: chatId);
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  String userId;
  String partnerId;
  String chatId;
  TextEditingController _reportMessage = new TextEditingController();
  final _formReportKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference chat = FirebaseFirestore.instance.collection("Chat");

  _ChatDetailPageState({required this.userId, required this.partnerId, required this.chatId});

  imageProfile(String pid) {

    StorageService ss = new StorageService();


    return FutureBuilder(
        future: ss.
        findDisplayPicture(pid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
            /*
              CircleAvatar(
              radius: 60.0,
            );
               */
          } else {
            print(snapshot.data.toString());
            return CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage('${snapshot.data.toString()}'),
            );
          }
        }
    );

  }

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
                  imageProfile(partnerId),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: users.
                          doc(partnerId).
                          get(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                "${snapshot.data!['DisplayName']}",
                                style: TextStyle(fontSize: 16, color: Constants.FONT_COLOR),);
                            }
                          }
                      ),
                      FutureBuilder(
                          future: users.
                          doc(partnerId).
                          get(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                "${snapshot.data!['SelfDescription']}",
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade800),);
                            }
                          }
                      ),
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
                          title: Text("Report User"),
                          content: Form(
                            key: _formReportKey,
                            child: TextFormField(
                              controller: _reportMessage,
                              validator: (value) {
                                if ((value == null) || (value.isEmpty)) {
                                  return "Report Message can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Why are you reporting this user?',
                                labelStyle: TextStyle(
                                    fontSize: 15,
                                ),
                                hintText: 'Explain here',
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    Firebase.INCREMENT_WARNING_COUNTER(partnerId);
                                    Firebase.UPDATE_WARNING_ARRAY(partnerId, _reportMessage.text);
                                    _reportMessage.clear();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("Ok")),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _reportMessage.clear();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("Cancel"))
                          ],
                        );
                      }
                  );
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => UserDetailMain(userId: userId, partnerId: partnerId, chatId: chatId)));
          },
        ),
        body: Scaffold(
          body: Container(
            child: Stack(
                children: [
                  ChatBody(userId: userId, partnerId: partnerId, chatId: chatId),
                ]
            )
          )
        ),
        bottomNavigationBar: BottomBar(userId: userId, chatId: chatId,),
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

  String userId;
  String partnerId;
  String chatId;

  ChatBody({required this.userId, required this.partnerId, required this.chatId});

  @override
  _ChatBodyState createState() => _ChatBodyState(userId: userId, partnerId: partnerId, chatId: chatId);
}

class _ChatBodyState extends State<ChatBody> {

  String userId;
  String partnerId;
  String chatId;

  _ChatBodyState({required this.userId, required this.partnerId, required this.chatId});

  CollectionReference chats = FirebaseFirestore.instance.collection('Chat');
  dynamic _chatStream;

  @override
  void initState() {
    _chatStream = chats.
    doc(chatId).
    collection("Messages").
    orderBy("sentAt").
    snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _chatStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return SingleChildScrollView(
                reverse: true,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 16),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return textBubble(
                                message: snapshot.data.docs[index].data()!['message'],
                                sendByMe: userId == snapshot.data.docs[index].data()!['sentBy'],
                                sendAt: snapshot.data.docs[index].data()!['sentAt'],
                              );
                            },
                          ),
                        ]
                    )
                )
            );
          }
        }
    );
  }
}

class textBubble extends StatelessWidget {

  final String message;
  final bool sendByMe;
  final Timestamp sendAt;

  textBubble({required this.message,required this.sendByMe, required this.sendAt});

  @override
  Widget build(BuildContext context) {

    DateTime sentAt = sendAt.toDate();
    int compare = DateTime.now().difference(sentAt).inDays;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
          top: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            (compare >=1) ? "${sentAt.day}-${sentAt.month}" : "${sentAt.hour}:${sentAt.minute}",
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey.shade800
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: 2,
              bottom: 8,
              left: sendByMe ? 0 : 24,
              right: sendByMe ? 24 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
              margin: sendByMe
                  ? EdgeInsets.only(left: 30)
                  : EdgeInsets.only(right: 30),
              padding: EdgeInsets.only(
                  top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: sendByMe ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23)
                ) :
                BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
                gradient: LinearGradient(
                    colors: [
                    const Color(0xff007EF4),
                    const Color(0xff2A75BC)
                    ],
              )
          ),
          child: Text(
                message,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300
                )
            ),
        ),
        )
    ]
    );
  }
}


class BottomBar extends StatefulWidget {

  String chatId;
  String userId;

  BottomBar({required this.chatId, required this.userId});

  @override
  _BottomBarState createState() => _BottomBarState(chatId: chatId, userId: userId);
}

class _BottomBarState extends State<BottomBar> {

  String chatId;
  String userId;
  _BottomBarState({required this.chatId, required this.userId});

  final _picker = ImagePicker();
  TextEditingController _message = new TextEditingController();
  bool _sentPictureUpdated = false;
  File _sentPicture = File("assets/Demo_Pic.jpg");

  addMessage() {
    if(_message.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sentBy": userId,
        "message": _message.text,
        'sentAt': Timestamp.now(),
      };

      FirebaseFirestore.
      instance.
      collection("Chat").
      doc(chatId).
      collection("Messages").
      add(chatMessageMap).
      catchError((e) {
        print(e.toString());
      });

      setState(() {
        _message.text = "";
      });

    }

  }

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
                              controller: _message,
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
                    onTap: () {
                      addMessage();
                    },
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
