// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test/models/chatusers.dart';
import 'package:test/chatdetail.dart';
import 'package:test/constants.dart';
import 'package:test/services/firebasechat.dart';
import 'package:test/services/query.dart';
import 'package:test/services/storage.dart';

class Chat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.BG_BASE,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {

  QueryService qs = new QueryService();
  dynamic _chatIds;
  dynamic uid; // User's uid
  bool show = false;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _chatIds = qs.getChatId(user.uid);
      uid = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BG_BASE,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 16, bottom: 5),
          child: Text(
            "Chats",
            style: TextStyle(
                color: Colors.black,
                fontSize: Constants.HEADER_SIZE,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
            ),
          )
        ),
      ),
        body:  FutureBuilder(
      future: _chatIds,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView (
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = snapshot.data[index];
                        return FutureBuilder(
                            future: FirebaseChat.CHECK_SHOW(snapshot.data[index], uid),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.data == false) {
                                return Dismissible(
                                  key: Key(item),
                                  child: ConversationList(
                                    chatId: item,
                                    alert: false,
                                  ),
                                  onDismissed: (direction) {
                                    // insert chat deletion code
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Chat has been deleted"),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text('All chat history will be deleted for both parties. Press OK to continue deletion'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () async {
                                                  FirebaseChat.UPDATE_ALERT_ARRAY(item, uid);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  background: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    color: Colors.red,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                      child: Icon(Icons.delete,
                                        color: Colors.white,

                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return FutureBuilder(
                                    future: FirebaseChat.CHECK_ALERT_DIALOG(item, uid),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.data == true) {
                                        return ConversationList(
                                          chatId: item,
                                          alert: true,
                                        );
                                      } else {
                                        return Container();
                                      }
                                });
                              }
                            }
                        );

                      },
                    ),
                  ]
                )
              )
          );
        }
      }
      )
    );
  }

}

class ConversationList extends StatefulWidget{

  final String chatId;
  final bool alert;

  ConversationList({required this.chatId, required this.alert});
  @override
  _ConversationListState createState() => _ConversationListState(chatId: chatId, alert: alert);
}

class _ConversationListState extends State<ConversationList> {

  QueryService qs = new QueryService();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chats = FirebaseFirestore.instance.collection('Chat');
  String chatId;
  bool alert;
  dynamic _partnerId;
  final bool isMessageRead = false;
  final String imageUrl = "assets/Demo_Pic.jpg";
  final ChatUsers user = ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now");


  _ConversationListState({required this.chatId, required this.alert});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    User? thisUser = FirebaseAuth.instance.currentUser;
    if (thisUser != null) {
      _partnerId = qs.fetchPartnerId(chatId, thisUser.uid);
    }

  }

  @override
  Widget build(BuildContext context) {

    User? thisUser = FirebaseAuth.instance.currentUser;
    String _userId = "buffer";
    if (thisUser != null) {
      _userId = thisUser.uid;
    }

    return Center(
      child: FutureBuilder(
          future: _partnerId,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              String pid = snapshot.data.toString(); // String value of the partner ID
              return GestureDetector(
                onTap: () {
                  if (alert) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Your partner has deleted the chat"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('All chat history will be deleted for both parties. Press OK to acknowledge.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () async {
                                  setState(() {
                                    FirebaseChat.DELETE_CHAT(chatId);
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  } else {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatDetailPage(userId: _userId,
                                  partnerId: pid,
                                  chatId: chatId,)));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: isMessageRead ? Constants.CHAT_BASE : Colors
                          .transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      )
                  ),
                  padding: EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            imageProfile(pid),
                            SizedBox(width: 16,),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FutureBuilder(
                                    future: users.
                                    doc(pid).
                                    get(),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        return Text(
                                          "${snapshot.data!['DisplayName']}",
                                          style: TextStyle(fontSize: 16),);
                                      }
                                    }
                                    ),
                                    SizedBox(height: 6,),
                                    FutureBuilder(
                                        future: chats.
                                        doc(chatId).
                                        collection("Messages").
                                        orderBy('sentAt').
                                        limitToLast(1).
                                        get()
                                        ,
                                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                          if (!snapshot.hasData) {
                                            return CircularProgressIndicator();
                                          } else {
                                            return Text(
                                              "${snapshot.data.docs[0]!['message']}",
                                              style: TextStyle(fontSize: 16),);
                                          }
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                          children: [
                            FutureBuilder(
                                future: chats.
                                doc(chatId).
                                collection("Messages").
                                orderBy('sentAt').
                                limitToLast(1).
                                get(),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    Timestamp extract = snapshot.data.docs[0]!['sentAt'];
                                    DateTime sentAt = extract.toDate();
                                    int compare = DateTime.now().difference(sentAt).inDays;
                                    if (compare >= 1) {
                                      return Text(
                                        "${sentAt.day}-${sentAt.month}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isMessageRead
                                                ? FontWeight.bold
                                                : FontWeight.normal
                                        ),
                                      );
                                    }
                                    return Text(
                                      "${sentAt.hour}:${sentAt.minute}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: isMessageRead
                                              ? FontWeight.bold
                                              : FontWeight.normal
                                      ),
                                    );
                                  }
                                }
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }

  imageProfile(String pid) {

    StorageService ss = new StorageService();
    

    return FutureBuilder(
        future: ss.
        findDisplayPicture(pid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircleAvatar(
              maxRadius: 30,
            );
          } else {
            print(snapshot.data.toString());
            return CircleAvatar(
              maxRadius: 30,
              backgroundImage: NetworkImage('${snapshot.data.toString()}'),
            );
          }
        }
    );

  }
  
}

