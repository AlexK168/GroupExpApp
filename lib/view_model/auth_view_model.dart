import 'package:flutter/material.dart';
import '../services/http/auth_service.dart';

enum NotifierState { initial, loading, loaded, failed }

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
}