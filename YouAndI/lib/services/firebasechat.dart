
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

  // checks the index of the uid
  static Future<void> UPDATE_ALERT_ARRAY(String chatId, String uid) async {

    int index = 2;
    // find the index of the userId the array
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
          value
              .get("Users")
              .forEach((element) {
            if (element == uid) {
              index = index*2;
            } else {
              index++;
            }
          })

      );

    } catch (e) {
      print(e);
    }

    if (index == 5) {
      index = 0;
    } else if (index == 6) {
      index = 1;
    }

    dynamic isAlert = [];
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
      isAlert = value.get("isAlerted")
      );

    } catch(e) {
      print(e);
    }

    isAlert[index] = true;

    return await chat
        .doc(chatId)
        .update({"isAlerted": isAlert})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));

  }

  // delete the chat
  static Future<void> DELETE_CHAT(String chatId) {
    return chat
        .doc(chatId)
        .delete();
  }

  // check whether chat should be shown
  // true : no need show
  // false: show
  static CHECK_SHOW(String chatId, String uid) async {
    int index = 2;
    // find the index of the userId the array
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
          value
              .get("Users")
              .forEach((element) {
            if (element == uid) {
              index = index*2;
            } else {
              index++;
            }
          })

      );

    } catch (e) {
      print(e);
    }

    if (index == 5) {
      index = 0;
    } else if (index == 6) {
      index = 1;
    }

    dynamic isAlert = [];
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
      isAlert = value.get("isAlerted")
      );

    } catch(e) {
      print(e);
    }

    if (isAlert[0] == false && isAlert[1] == false) {
      return false;
    } else {
      return true;
    }

  }

  static CHECK_ALERT_DIALOG (String chatId, String uid) async {

    int index = 2;
    int index1 = 4;
    // find the index of the userId the array
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
          value
              .get("Users")
              .forEach((element) {
            if (element == uid) {
              index = index*2;
            } else {
              index++;
            }
          })

      );

    } catch (e) {
      print(e);
    }

    if (index == 5) {
      index = 0;
      index1 = 1;
    } else if (index == 6) {
      index = 1;
      index1 = 0;
    }

    dynamic isAlert = [];
    try {
      await chat
          .doc(chatId)
          .get()
          .then((value) =>
      isAlert = value.get("isAlerted")
      );

    } catch(e) {
      print(e);
    }

    print(isAlert[index]);
    print(isAlert[index1]);
    if (isAlert[index] == false && isAlert[index1] == true) {
      return true;
    } else {
      return false;
    }

  }


}