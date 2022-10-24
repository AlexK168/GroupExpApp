import 'package:flutter/material.dart';
import 'package:groupexp/view_model/util.dart';

import '../exceptions/failure.dart';
import '../model/party.dart';
import '../services/http/parties_service.dart';


class PartiesViewModel extends ChangeNotifier {
  List<Party> parties = [];
  final partiesService = PartiesService();

  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void getParties(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      parties = await partiesService.getParties();
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }
}