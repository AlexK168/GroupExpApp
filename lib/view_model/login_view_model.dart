import 'package:flutter/material.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:groupexp/view_model/util.dart';

import '../screens/parties_page.dart';
import 'auth_view_model.dart';

class LoginViewModel extends AuthViewModel {
  void login(BuildContext context) async {
    setState(NotifierState.loading);
    String email = emailController.value.text;
    String pass = passController.value.text;
    User u = User(email: email, password: pass);
    try {
      token = await authService.login(u);
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
      return;
    }
    await saveTokenToPrefs();
    setState(NotifierState.loaded);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const PartiesPage(),
      ),
    );
  }
}