
import 'package:flutter/material.dart';
import 'package:test/chatdetail.dart';
import 'package:test/chatusers.dart';
import 'package:test/constants.dart';

class UserDetailMain extends StatelessWidget {

  final ChatUsers user;

  const UserDetailMain ({Key? key, required this.user}) : super(key: key);

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
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => ChatDetailPage(user: user)));
          },
        ),
      ),
      body: UserDetail(user: user,),
    );
  }
}


class UserDetail extends StatefulWidget {

  final ChatUsers user;

  UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState(user: user);

}

class _UserDetailState extends State<UserDetail> {

  final ChatUsers user;

  _UserDetailState({required this.user});

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
              Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => PictureDetail(user: user,)));
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
          Text(
            user.name,
            style: TextStyle(
              color: Constants.FONT_COLOR,
            ),
          ),
        ],
      ),
    );
  }

}

class PictureDetail extends StatelessWidget {

  final ChatUsers user;

  PictureDetail({required this.user});

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
              Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => UserDetailMain(user: user)));
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




