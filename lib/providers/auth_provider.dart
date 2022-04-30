import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  AuthStatus authStatus = AuthStatus.notAuthenticated;

  AuthProvider() {
    isAuthenticated();
  }

  Future<bool> isAuthenticated() async {
    if (user == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}
