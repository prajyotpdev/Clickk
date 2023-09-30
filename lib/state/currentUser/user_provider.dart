import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User? _user ;

  User? get user => _user;

  void setUser(User? user) {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
