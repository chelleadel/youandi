
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/models/users.dart';

class Firebase {

  static CollectionReference users = FirebaseFirestore.instance.collection('Users');

  static Future<void> ADD_USER_STRING(String userId, String key, String item) {
    return users
        .doc(userId)
        .set({key: item,})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> UPDATE_USER_STRING(String userId, String key, String item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_USER_INT(String userId, String key, int item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_USER_BOOL(String userId, String key, bool item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_USER_DOUBLE(String userId, String key, double item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_USER_TIME(String userId, String key, DateTime item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_USER_ARRAY(String userId, String key, List item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> CREATE_WARNING_ARRAY(String userId) {
    return users
        .doc(userId)
        .update({"warningArray": []})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> INCREMENT_WARNING_COUNTER(String userId) {
    return users
        .doc(userId)
        .update({"warningCounter": FieldValue.increment(1)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> UPDATE_WARNING_ARRAY(String userId, String reason) {
    return users
        .doc(userId)
        .update({"warningArray": FieldValue.arrayUnion([reason])})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<dynamic> GET_USER(String userId) {
    return users
        .doc(userId)
        .get();
  }


}