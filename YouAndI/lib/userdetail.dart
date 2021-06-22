import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/chatdetail.dart';
import 'package:test/models/chatusers.dart';
import 'package:test/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(user.imageURL),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
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
        ],
      ),
    );
  }

}

class PictureDetail extends StatelessWidget {

  final String userId;
  final String partnerId;
  final String chatId;

  final ChatUsers user = ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now");

  PictureDetail({required this.userId, required this.partnerId, required this.chatId});

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
                child: Image.asset(user.imageURL),
              ),
            ],
          ),
        )
    );
  }
}




