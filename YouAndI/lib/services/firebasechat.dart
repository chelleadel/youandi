
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChat {

  static CollectionReference chat = FirebaseFirestore.instance.collection('Chat');

  static Future<void> ADD_USER_ARRAY(String userId, String key, List item) {
    return chat
        .doc(userId)
        .set({
      key: item,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> ADD_MESSAGE_COLLECTION(String userId) {
    return chat
        .doc(userId)
        .collection('Messages')
        .add({});
  }

  static Future<void> ADD_FIRST_MESSAGE(String userId) {
    return chat
        .doc(userId)
        .collection('Messages')
        .add({
      "message": "Hello! Say hi to your new partner!!!",
      "sentBy": userId,
      "sentAt": DateTime.now(),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

}