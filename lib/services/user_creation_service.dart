import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserCreationService extends ChangeNotifier {
  bool validNickname = false;
  var uuid = const Uuid();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference nicknames =
      FirebaseFirestore.instance.collection('nicknames');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> checkUserNickname(String nickname) async {
    final resp = await nicknames.doc(nickname).get();

    if (resp.exists) {
      validNickname = false;
      notifyListeners();
    }
    if (!resp.exists) {
      validNickname = true;
      notifyListeners();
    }
  }

  Future<void> postNickName(String nickname) async {
    return nicknames.doc(nickname).set({'nickname': nickname});
  }

  Future<void> postUser(String email, String interest, String nickname) async {
    final String uid = uuid.v4();
    return users
        .doc(uid)
        .set({
          'name': '',
          'email': email,
          'nickname': nickname,
          'uid': uid,
          'interest': interest,
          'tasks': []
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
