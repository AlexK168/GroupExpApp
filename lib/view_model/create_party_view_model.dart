import 'package:flutter/material.dart';
import 'package:groupexp/services/http/parties_service.dart';
import 'package:groupexp/view_model/util.dart';

import '../exceptions/failure.dart';
import '../model/party.dart';
import '../model/user.dart';

class CreatePartyViewModel extends ChangeNotifier {
  final PartiesService service = PartiesService();

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  String partyName = "";
  List<User> members = [];

  void addMembers(List<User> users, BuildContext context) {
    for (User u in users) {
      if (members.contains(u)) {
        showInSnackBar("User is already in list", context);
        continue;
      }
      members.add(u);
    }
    notifyListeners();
  }

  void createParty(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      Party party = Party(UsersList(users: members), partyName);
      await service.createParty(party);
      Navigator.of(context).pop();
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

}