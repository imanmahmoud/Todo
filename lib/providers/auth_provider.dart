import 'package:flutter/material.dart';

import '../model/user_model.dart';


class AuthProvider extends ChangeNotifier{
  MyUser? currentUser;


  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}