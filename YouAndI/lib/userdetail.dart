import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/chatdetail.dart';
import 'package:test/models/chatusers.dart';
import 'package:test/constants.dart';
import 'package:test/services/storage.dart';

class UserDetailMain extends StatelessWidget {

  final String userId;
  final String partnerId;
  final String chatId;

  final ChatUsers user = ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now");

  UserDetailMain ({required this.userId, required this.partnerId, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.BG_BASE,
        centerTitle: false,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => ChatDetailPage(userId: userId, partnerId: partnerId, chatId: chatId)));
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: UserDetail(userId: userId, partnerId: partnerId, chatId: chatId),
    );
  }
}


class UserDetail extends StatefulWidget {

  final String userId;
  final String partnerId;
  final String chatId;

  UserDetail({required this.userId, required this.partnerId, required this.chatId});

  @override
  _UserDetailState createState() => _UserDetailState(userId: userId, partnerId: partnerId, chatId: chatId);

}

class _UserDetailState extends State<UserDetail> {

  String userId;
  String partnerId;
  String chatId;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  final ChatUsers user = ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now");

  _UserDetailState({required this.userId, required this.partnerId, required this.chatId});

  imageProfile(String pid) {

    StorageService ss = new StorageService();
    
    return FutureBuilder(
        future: ss.
        findDisplayPicture(pid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('${snapshot.data.toString()}'),
            );
          }
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: new SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => PictureDetail(userId: userId, partnerId: partnerId, chatId: chatId)));
              },
              child: Hero(
                tag: user.imageURL,
                child: Container(
                    child: imageProfile(partnerId)
                ),
              ),
            ),
            SizedBox(height: 30),
            FutureBuilder(
                future: users.
                doc(partnerId).
                get(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                                child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NAME",
                                        style: TextStyle(
                                            color: Colors.grey.shade700
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                color: Constants.BG_BASE,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Divider(
                                            color: Colors.grey.shade500,
                                          ),
                                          SizedBox(height: 40,),
                                          Expanded(
                                            child: Text(
                                              "${snapshot.data!['DisplayName']}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: Constants.BUTTON_FONT_SIZE,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Divider(
                                            color: Colors.grey.shade500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40,),
                              Container(
                                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                                child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "EMAIL",
                                        style: TextStyle(
                                            color: Colors.grey.shade700
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  color: Constants.BG_BASE,
                                  child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                              SizedBox(height: 40,),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!['Email']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(height: 30,),
                              Container(
                                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                                child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ABOUT",
                                        style: TextStyle(
                                            color: Colors.grey.shade700
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  color: Constants.BG_BASE,
                                  child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                              SizedBox(height: 40,),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!['SelfDescription']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(height: 30,),
                              Container(
                                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                                child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "GENDER",
                                        style: TextStyle(
                                            color: Colors.grey.shade700
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  color: Constants.BG_BASE,
                                  child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                              SizedBox(height: 40,),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!['Gender']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: Constants.BUTTON_FONT_SIZE,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(height: 30,),
                              Container(
                                margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                                child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DATE OF BIRTH",
                                        style: TextStyle(
                                            color: Colors.grey.shade700
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  color: Constants.BG_BASE,
                                  child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                              SizedBox(height: 40,),
                                              Expanded(
                                                child: Text(
                                                  //"${snapshot.data!['DOB'].toDate()}",
                                                  "${DateFormat.yMMMd().format(snapshot.data!['DOB'].toDate())}",
                                                  //overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: Constants.BUTTON_FONT_SIZE,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Divider(
                                                color: Colors.grey.shade500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(height: 40,),
                            ]
                        )

                    );
                  }
                }
            ),
          ],
        ),
      )
    );
  }

}

class PictureDetail extends StatelessWidget {

  final String userId;
  final String partnerId;
  final String chatId;

  final ChatUsers user = ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now");

  PictureDetail({required this.userId, required this.partnerId, required this.chatId});

  imageProfile(String pid) {
    
    StorageService ss = new StorageService();
    
    return FutureBuilder(
        future: ss.
        findDisplayPicture(pid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return Image.network('${snapshot.data.toString()}');
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constants.BG_BASE,
          centerTitle: false,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Back',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => UserDetailMain(userId: userId, partnerId: partnerId, chatId: chatId)));
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                transitionOnUserGestures: true,
                tag: user.imageURL,
                child: imageProfile(partnerId),
              ),
            ],
          ),
        )
    );
  }
}



