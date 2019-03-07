import 'package:flutter/material.dart';
import 'package:fourybyoffline/data/database.dart';

class UserResponse {
  final String question;
  final String answer;

  UserResponse({@required this.question, @required this.answer});

  saveResponse({@required int studyID, @required String type}) async {
    var db = new DatabaseHelper();
      int res; 
      try {
        res = await db.save(question, answer, studyID);
      } catch(e) {
        print(e.message);
      } finally {
        print('RESSSSS $res');
      }

    // if (user == null) {
    //   return;
    // }
    // FirebaseDatabase.instance
    //     .reference()
    //     .child('users')
    //     .child(user.uid)
    //     .child(type)
    //     .child(question)
    //     .set(answer);
  }
}
