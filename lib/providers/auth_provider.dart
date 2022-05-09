import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/models/user_model.dart';
import 'package:task_manager/providers/navigator_provider.dart';
import 'package:task_manager/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  AuthStatus authStatus = AuthStatus.checking;
  String? errorMessage;
  final CollectionReference nicknames =
      FirebaseFirestore.instance.collection('nicknames');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

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

  void signUp(
      String email, String password, String interest, String nickname) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postNickName(nickname),
                postUser(interest, nickname),
                authStatus = AuthStatus.authenticated,
                notifyListeners(),
                NavigatorService.replaceTo('home')
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          errorMessage = 'Ya hay un usuario registrado con ese email';
          break;
        case "weak-password":
          errorMessage = 'La contraseña introducida es muy débil';
          break;
        default:
          errorMessage = 'Se ha producido un error';
      }
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      SmartDialog.show(widget: NotificationToast(msg: errorMessage!));
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                authStatus = AuthStatus.authenticated,
                notifyListeners(),
                Fluttertoast.showToast(msg: 'Login correcto'),
                NavigatorService.replaceTo('home')
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "user-not-found":
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
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  void logOut() async {
    await auth.signOut();
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'No tenemos este email registrado';
          break;
        default:
          errorMessage = 'No tenemos este email registrado';
      }
      SmartDialog.show(widget: NotificationToast(msg: errorMessage!));
    }
  }

  Future<void> postUser(String interest, String nickname) async {
    final User? user = auth.currentUser;
    final String uid = auth.currentUser!.uid;

    return await users
        .doc(uid)
        .set({
          'name': '',
          'email': user!.email,
          'nickname': nickname,
          'uid': uid,
          'interest': interest,
          'tasks': []
        })
        // ignore: avoid_print
        .then((value) => print('Usuario añadido'))
        .catchError((e) {
          if (kDebugMode) {
            print(e);
          }
        });
  }

  Future<void> postNickName(String nickname) async {
    return nicknames.doc(nickname).set({'nickname': nickname});
  }
}
