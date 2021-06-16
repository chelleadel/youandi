
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> addUser(String userId, String key, String item) {
    return users
        .doc(userId)
        .set({
      key: item,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String userId, String key, String item) {
    return users
        .doc(userId)
        .update({key: item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}