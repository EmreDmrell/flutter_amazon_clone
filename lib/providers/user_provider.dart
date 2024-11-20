import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/User/user.dart';

class UserProvider extends ChangeNotifier {
  User _user =  User(
    '',
    '',
    '',
    '',
    '',
    '',
    '',

  );

  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(jsonDecode(user));
    notifyListeners();
  }
}
