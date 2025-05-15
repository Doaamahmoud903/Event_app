import 'package:event_app/modals/auth_model.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  MyUser? currentUser;

  void setCurrentUser(MyUser? user) {
    currentUser = user;
    notifyListeners();
  }
}
