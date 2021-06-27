/* Notes
Q1- I am looking for; [1- Romantic R/S, 2- Friendship, 3- Both]
Q2- Pair me with a; [1- Female, 2- Male, 3- Both]
Lower/Upper Age preference; [LowerAgePreference, UpperAgePreference]
Q3- My perfect day; [1- Chilling at home, 2- Going for a food trip, 3- Going for shopping,
    4- Visiting tourist attractions, 5- Doing physical activities]

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/services/firebase.dart';
import 'package:test/services/firebasechat.dart';

class Matching {
  static var currentUser = FirebaseAuth.instance.currentUser;


  static int MAX_MATCHES = 1;

  static test() {
    print("testing");
  }

   static bool hasMaxMatches(int sample) {
    return sample == MAX_MATCHES;
  }

  static void findMatch(String ownEmail) {
    int counter = 0;
    bool updated = false;
    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["NumberOfMatch"] < MAX_MATCHES) {
          if (Matching.matching(doc["Email"]) && doc["Email"] != ownEmail) {
            print("UID");
            print(doc.id);

            counter = counter + 1;
            if (counter == 1 && updated == false) {
              print("Updating");
              Firebase.UPDATE_USER_INT(doc.id, "NumberOfMatch", doc["NumberOfMatch"] + 1);
              Firebase.UPDATE_USER_INT(currentUser!.uid, "NumberOfMatch", doc["NumberOfMatch"] + 1);
              updated = true;
              List userArray = [currentUser!.uid, doc.id];
              // to add Chat data
              FirebaseChat.ADD_USER_ARRAY(currentUser!.uid + doc.id,"Users", userArray);
              FirebaseChat.ADD_MESSAGE_COLLECTION(currentUser!.uid + doc.id);
              // change alert to false
              Firebase.UPDATE_USER_BOOL(currentUser!.uid, "IsUserAlerted", false);
              Firebase.UPDATE_USER_BOOL(doc.id, "IsUserAlerted", false);
            }
          }
        }
      });
    });
  }

  static bool matching(String potentialEmail) {
    //return true;
    return potentialEmail == "e0544112@u.nus.edu";
  }
}