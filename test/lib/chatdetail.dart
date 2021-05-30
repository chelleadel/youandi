import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Detail"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.report),
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
        body: Container()
    );
  }
}