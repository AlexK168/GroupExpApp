import 'package:flutter/material.dart';
import 'package:groupexp/services/http/friends_service.dart';
import 'package:groupexp/view_model/util.dart';

import '../exceptions/failure.dart';
import '../model/user.dart';

class UsersSearchViewModel extends ChangeNotifier {
  FriendsService service = FriendsService();
  List<User> usersToAdd = [];

  Future<List<User>> getSuggestions(BuildContext context, String query) async {
    List<User> emptyUserList = [];
    if (query.isEmpty) {
      return emptyUserList;
    }
    String searchPhrase = query.toLowerCase();
    try {
      List<User> users = await service.getUsers();
      List<User> filteredUsers = users.where((user) {
        String username = user.username.toLowerCase();
        return username.contains(searchPhrase);
      }).toList();
      return filteredUsers;
    } on Failure catch (f) {
      showInSnackBar(f.toString(), context);
      return emptyUserList;
    }
  }

  void addUserToList(BuildContext context, User user) {
    if (usersToAdd.contains(user)) {
      showInSnackBar("User is already in list", context);
      return;
    }
    usersToAdd.add(user);
    showInSnackBar("User added to list", context);
    notifyListeners();
  }

  void removeUserAt(int index) {
    usersToAdd.removeAt(index);
    notifyListeners();
  }

  Future<void> addFriends(BuildContext context) async {
    try {
      await service.addFriends(usersToAdd);
      showInSnackBar("Added to friends list", context);
      return;
    } on Failure catch (f) {
      showInSnackBar(f.toString(), context);
      return;
    }
  }
}