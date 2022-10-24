import 'package:flutter/material.dart';
import 'package:groupexp/services/http/friends_service.dart';
import 'package:groupexp/view_model/util.dart';

import '../exceptions/failure.dart';
import '../model/user.dart';

class FriendsViewModel extends ChangeNotifier {
  List<User> friends = [];
  List<bool> selected = [];
  final friendsService = FriendsService();

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  bool selectMode = false;

  void select(int index) {
    if (!selectMode) {
      return;
    }
    if (selected[index]) {
      selected[index] = false;
    } else {
      selected[index] = true;
    }
    notifyListeners();
    if (!selected.any((element) => element)) {
      toSelectMode(false);
    }
  }

  void toSelectMode(bool mode) {
    selectMode = mode;
    notifyListeners();
  }

  List<User> getSelectedUsers() {
    List<User> res = [];
    selected.asMap().forEach((key, value) {
      if (value) {
        res.add(friends[key]);
      }
    });
    return res;
  }

  void getFriends(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      friends = await friendsService.getFriends();
      selected = friends.map((_)=>false).toList();
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }
}