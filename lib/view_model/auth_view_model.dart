import 'package:flutter/material.dart';
import 'package:groupexp/view_model/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/http/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late String token;

  Future saveTokenToPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
}
