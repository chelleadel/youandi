import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test/profile.dart';

class Chat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100,
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text("Chat"),
      ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chat here!',
                    style: TextStyle(fontSize: 48, fontFamily: 'BubblerOne'),
                  ),
                  SizedBox(height: 60),
                ]
            )
        ),
      bottomSheet: bottomSheet(),
    );

  }

  Widget bottomSheet() {
    return Container(
        //color: Colors.cyan,
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child:
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(
                      Icons.list,
                      color: Colors.black,
                  ),
                  label: Text(
                    "Chat",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  icon: Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                  ),
                  label: Text(
                      "Profile",
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                ),
              ],
            ),
        );
  }

}