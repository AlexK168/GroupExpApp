import 'package:flutter/material.dart';
import 'package:groupexp/services/http/login_services.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';

enum NotifierState { initial, loading, loaded, failed }

class LoginViewModel extends ChangeNotifier {
  final _loginService = LoginService();

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

  Failure? _failure;
  Failure? get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
  }

  void setToInit() {
    _state = NotifierState.initial;
  }

  void login(User user) async {
    _setState(NotifierState.loading);
    try {
      final String token = await _loginService.login(user);
      _setToken(token);
    } on Failure catch (f) {
      _setFailure(f);
      _setState(NotifierState.failed);
      return;
    }
    //TODO: save data to shared pref-s.

    _setState(NotifierState.loaded);
  }
}