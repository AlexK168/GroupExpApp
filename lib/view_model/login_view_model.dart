import 'package:flutter/material.dart';
import 'package:groupexp/services/http/login_services.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';

import '../screens/parties_page.dart';

enum NotifierState { initial, loading, loaded, failed }

class LoginViewModel extends ChangeNotifier {
  final _loginService = AuthService();

  late TextEditingController _emailController = TextEditingController();
  void setEmailController(controller) {
    _emailController = controller;
  }
  TextEditingController get emailController => _emailController;


  late TextEditingController _passController = TextEditingController();
  void setPassController(controller) {
    _passController = controller;
  }
  TextEditingController get passController => _passController;

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late String _token;
  String get token => _token;
  void _setToken(String token) {
    _token = token;
  }


  void login(BuildContext context) async {
    String email = emailController.value.text;
    String pass = passController.value.text;
    User u = User(email: email, password: pass);
    _setState(NotifierState.loading);
    try {
      final String token = await _loginService.login(u);
      _setToken(token);
    } on Failure catch (f) {
      _setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
      return;
    }

    //TODO: save data to shared pref-s.

    _setState(NotifierState.loaded);
    //TODO: push and remove prev route so the user can't get back
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PartiesPage())
    );
  }

  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}