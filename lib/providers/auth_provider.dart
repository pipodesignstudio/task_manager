import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  AuthStatus authStatus = AuthStatus.notAuthenticated;
  String? errorMessage;

  AuthProvider() {
    isAuthenticated();
  }

  Future<void> isAuthenticated() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
      } else {
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      }
    });
  }

  void signUp(String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                authStatus = AuthStatus.authenticated,
                notifyListeners(),
              })
          .catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'El email no corresponde con ningún usuario';
          break;
        case "wrong-password":
          errorMessage =
              'La contraseña con corresponde con el email introducido';
          break;
        default:
          errorMessage = 'Se ha producido un error';
      }
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      SmartDialog.show(
          widget: Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(errorMessage!, style: TextStyle(color: Colors.white)),
      ));
    }
  }

  void logIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                authStatus = AuthStatus.authenticated,
                notifyListeners(),
              })
          .catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'El email no corresponde con ningún usuario';
          break;
        case "wrong-password":
          errorMessage =
              'La contraseña con corresponde con el email introducido';
          break;
        default:
          errorMessage = 'Se ha producido un error';
      }
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      SmartDialog.show(
          widget: Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(errorMessage!, style: TextStyle(color: Colors.white)),
      ));
    }
  }

  void LogOut() async {
    auth.signOut();
  }
}
