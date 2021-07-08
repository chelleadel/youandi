/* Notes
Q1- I am looking for; [1- Romantic R/S, 2- Friendship, 3- Both]
Q2- Pair me with a; [1- Female, 2- Male, 3- Both]
Lower/Upper Age preference; [LowerAgePreference, UpperAgePreference]
Q3- My perfect day; [1- Chilling at home, 2- Going for a food trip, 3- Going for shopping,
    4- Visiting tourist attractions, 5- Doing physical activities]

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:test/services/firebase.dart';
import 'package:test/services/firebasechat.dart';

class Matching {
  static var currentUser = FirebaseAuth.instance.currentUser;


  static int MAX_MATCHES = 1;

  static test() {
    print("testing");
  }

  static int calculateAge(Timestamp time) {
    DateTime birthday = time.toDate();
    DateTime currentTime = DateTime.now();
    if (currentTime.month < birthday.month) {
      return currentTime.year - birthday.year - 1; // return
    } else if (currentTime.month > birthday.month) {
      return currentTime.year - birthday.year; // return
    } else if (currentTime.day < birthday.day) {
      return currentTime.year - birthday.year - 1; // return
    } else {
      return currentTime.year - birthday.year; // return
    }
  }

   static bool hasMaxMatches(int sample) {
    return sample == MAX_MATCHES;
  }

  static void findMatch(String email, String gender, int lowerAge, int upperAge, String q1, String q2, String q3, Timestamp DOB) {
    int counter = 0;
    bool updated = false;
    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["NumberOfMatch"] < MAX_MATCHES) {
          if (Matching.matching(email, gender, lowerAge, upperAge, q1, q2, q3, DOB,
          doc["Gender"], doc["LowerAgePreference"], doc["UpperAgePreference"], doc["Q1"].toString(), doc["Q2"].toString(), doc["Q3"].toString(), doc['DOB'])
              && doc["Email"] != email) {
            print("UID");
            print(doc.id);

            counter = counter + 1;
            if (counter == 1 && updated == false) {
              print("Updating");
              Firebase.UPDATE_USER_INT(doc.id, "NumberOfMatch", doc["NumberOfMatch"] + 1);
              Firebase.UPDATE_USER_INT(currentUser!.uid, "NumberOfMatch", doc["NumberOfMatch"] + 1);
              List userArray = [currentUser!.uid, doc.id];
              // to add Chat data
              FirebaseChat.ADD_USER_ARRAY(currentUser!.uid + doc.id,"Users", userArray);
              FirebaseChat.ADD_MESSAGE_COLLECTION(currentUser!.uid + doc.id);
              // change alert to false
              Firebase.UPDATE_USER_BOOL(currentUser!.uid, "IsUserAlerted", false);
              Firebase.UPDATE_USER_BOOL(doc.id, "IsUserAlerted", false);
              updated = true;
            }
          }
        }
      });
    });
  }

  static bool matching(String myEmail, String myGender, int myLowerAge, int myUpperAge, String myQ1, String myQ2, String myQ3,
  Timestamp myDOB,
  String gender, int lowerAge, int upperAge, String q1, String q2, String q3, Timestamp DOB) { // left with age

    if (myQ2 == "1") {
      myQ2 = 'Female';
    } else {
      myQ2 = 'Male';
    }
    if (q2 == "1") {
      q2 = 'Female';
    } else {
      q2 = 'Male';
    }

    if (q2 == myGender && myQ2 == gender) {
      if (calculateAge(myDOB) < upperAge && calculateAge(myDOB) > lowerAge && calculateAge(DOB) > myLowerAge && calculateAge(DOB) < myUpperAge) {
        if (myQ1 == '1' && q1 == '1') {
          if (myQ3 == q3) {
            return true;
          }
        }
        if (myQ1 == '2' && q1 == '2') {
          if (myQ3 == q3) {
            return true;
          }
        }
        if (myQ1 == '3' && q1 == '3') {
          if (myQ3 == q3) {
            return true;
          }
        }
      }
    }
    return false;
  }
}