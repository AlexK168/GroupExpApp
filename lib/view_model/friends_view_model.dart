import 'package:flutter/material.dart';
import 'package:groupexp/services/http/friends_service.dart';
import 'package:groupexp/view_model/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/failure.dart';
import '../model/user.dart';

class FriendsViewModel extends ChangeNotifier {
  List<User> friends = [];
  final friendsService = FriendsService();

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void getFriends(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = (prefs.getString('token') ?? "");
      if (token == "") {
        throw Failure("You are logged off. Please, log in");
      }
      friends = await friendsService.getFriends(token);
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }
}