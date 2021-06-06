import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test/chatusers.dart';
import 'package:test/chatdetail.dart';

class Chat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow[50],
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
    ChatUsers("Michelle", "Wow u look amazing", "assets/Demo_Pic.jpg", "Yesterday"),
    ChatUsers("Advisor", "Take a look at team You&I! They are insanely good", "assets/Demo_Pic.jpg", "31 Mar"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 16, bottom: 5),
          child: Text(
            "Chats",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
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
                      name: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      imageUrl: chatUsers[index].imageURL,
                      time: chatUsers[index].time,
                      isMessageRead: (index == 0 || index == 3)?true:false,
                    );
                  },
                ),]
            )
        ),
    );
  }

}

class ConversationList extends StatefulWidget{
  String name = "en";
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList({required this.name, required this.messageText, required this.imageUrl, required this.time, required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => ChatDetailPage()));
        },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isMessageRead ? Colors.yellow.shade100 : Colors.transparent,
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
                    backgroundImage: NetworkImage(widget.imageUrl),
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
                            widget.name,
                            style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead ? FontWeight.bold : FontWeight.normal
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
                  widget.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.isMessageRead ? FontWeight.bold : FontWeight.normal
                  ),
                ),
                SizedBox(height: 3),
                widget.isMessageRead
                    ? Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.yellow.shade800,
                )
                    : Text(''),
              ]
            ),
          ],
        ),
      ),
    );
  }
}