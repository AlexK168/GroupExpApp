import 'package:flutter/material.dart';
import 'package:groupexp/view_model/auth_view_model.dart';
import 'package:groupexp/view_model/util.dart';

import '../exceptions/failure.dart';
import '../model/user.dart';
import '../screens/parties_page.dart';

class RegisterViewModel extends AuthViewModel {
  void register(BuildContext context) async {
    setState(NotifierState.loading);
    String email = emailController.text;
    String pass = passController.text;
    String username = usernameController.text;
    User u = User(email: email, password: pass, username: username);
    try {
      await authService.register(u);
      token = await authService.login(u);

    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
      return;
    }

    //TODO: save data to shared pref-s.

    setState(NotifierState.loaded);
    //TODO: push and remove prev route so the user can't get back
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PartiesPage())
    );
  }
}