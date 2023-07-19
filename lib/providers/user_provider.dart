import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/screens/onboarding_screen.dart';
import 'package:educloud_mobile/services/user_services.dart';
import 'package:flutter/material.dart';

class UserProvider extends BaseProvider {
  String? username;
  String? password;
  String? get user_name => this.username;
  String? get pass => this.password;
  void setUsername(String? name) {
    this.username = name;
    notifyListeners();
  }

  void setPasswdor(String? pass) {
    this.password = pass;
    notifyListeners();
  }

  UserServices userServices = UserServices();
  Future<bool> isLoginSuccess(String username, String pass) async {
    return await userServices.loginApi(username, pass);
  }
}
