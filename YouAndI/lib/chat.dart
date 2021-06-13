import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test/chatusers.dart';
import 'package:test/chatdetail.dart';
import 'package:test/constants.dart';

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

  List<ChatUsers> chatUsers = [
    ChatUsers("Brandon", "HAHAHAHA", "assets/Demo_Pic.jpg", "Now"),
    ChatUsers("Michelle", "Wow u look amazing", "assets/logo.png", "Yesterday"),
    ChatUsers("Advisor", "Take a look at team You&I! They are insanely good", "assets/spirit.png", "31 Mar"),
  ];

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
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                ListView.builder(
                  itemCount: chatUsers.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return ConversationList(
                      chatUser: chatUsers[index],
                    );
                  },
                ),]
            )
        ),
    );
  }

}

class ConversationList extends StatefulWidget{

  final ChatUsers chatUser;

  ConversationList({required this.chatUser});
  @override
  _ConversationListState createState() => _ConversationListState(user: chatUser);
}

class _ConversationListState extends State<ConversationList> {

  final ChatUsers user;

  _ConversationListState({required this.user});

  @override
  Widget build(BuildContext context) {

    String name = user.name;
    String messageText =  user.messageText;
    String imageUrl =  user.imageURL;
    String time  = user.time;
    bool isMessageRead = (name.length <= 7)?true : false;


    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => ChatDetailPage(user: user,)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: isMessageRead ? Constants.CHAT_BASE : Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            )
        ),
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(
                            messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: isMessageRead ? FontWeight.bold : FontWeight.normal
                            ),
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
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: isMessageRead ? FontWeight.bold : FontWeight.normal
                    ),
                  ),
                  /*SizedBox(height: 3),
                  isMessageRead
                      ? Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.yellow.shade800,
                  )
                      : Text(''),
                   */
                ]
            ),
          ],
        ),
      ),
    );
  }
}