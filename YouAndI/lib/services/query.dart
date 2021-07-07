import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class QueryService {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference chat = FirebaseFirestore.instance.collection('Chat');

  // return List of ChatID
  getChatId(String uid) async {

    dynamic listOfChat = [];

    await chat.
    where('Users', arrayContains: uid).
    get().
    then((value) {
        value.
        docs.
        forEach((element) {
          listOfChat.add(element.id);
          print("here: " + element.id);
        });
      }
    );

    return listOfChat;
  }

  // return a List of message documents
  fetchMessageByChatId(String chatId) async {
    return chat.
      doc(chatId).
      collection('Messages').
      orderBy('sentAt').
      snapshots();
  }

  // fetch the partner's data!
  fetchPartnerId(String chatId, String myId) async {

    dynamic ids = [];

    await chat.
      doc(chatId).
      get().
      then((value) =>
        ids = value.get('Users')
      );

    for (int i = 0; i < 2; i++) {
      if (ids[i] != myId) {
        print(ids[i]);
        return await ids[i];
      }
    }

    print("clowns!");
    return null;
  }


}