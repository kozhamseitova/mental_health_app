import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/services/navigation_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {

  User? user;

  AuthStatus? status;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      status = AuthStatus.Authenticated;
      print("Success login");
      NavigationService.instance.navigateToReplacement("main");
    } catch(e) {
      status = AuthStatus.Error;
      print("Login err");
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String email, String password, Future<void> Function(String uid) onSuccess) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      user = result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user!.uid);
      NavigationService.instance.navigateToReplacement("main");
    } catch(e) {
      status = AuthStatus.Error;
      print(e);
      user = null;
    }
    notifyListeners();
  }

 void logoutUser() async {
    try {
      await _auth.signOut();
      user = null;
      status = AuthStatus.NotAuthenticated;
      await NavigationService.instance.navigateToReplacement("login");
    } catch(e) {
      print(e);
    }
    notifyListeners();
  }
}
