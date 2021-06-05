import 'package:flutter/material.dart';
import 'package:test/homepage.dart';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.cyan.shade800,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Chat Page',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          title: Text(
              "Chat Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold
              ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
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
        body: Container(),
        bottomNavigationBar: null
    );
  }
}