import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService {

  addDisplayPicture(String uid, String imagePath) async {

    try {
      await FirebaseStorage.instance
          .ref('displayPictures/${uid}')
          .putFile(File(imagePath));
    } catch(e) {
      print(e);
    }

  }

  deleteDisplayPicture(String uid) async {

    try {
      await FirebaseStorage.instance
          .ref('displayPictures/${uid}')
          .delete();
    } catch(e) {
      print(e);
    }

  }

  findDisplayPicture(String uid) async {
    return await FirebaseStorage.instance
        .ref('displayPictures/${uid}')
        .getDownloadURL();
  }



}