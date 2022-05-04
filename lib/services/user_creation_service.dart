import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCreationService extends ChangeNotifier {
  bool validNickname = false;
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

  Future<void> postUser(String uid, String email, String interest) async {}
}
