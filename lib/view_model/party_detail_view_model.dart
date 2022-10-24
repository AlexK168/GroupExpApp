import 'package:flutter/material.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/change_debt.dart';
import 'package:groupexp/model/contribution.dart';
import 'package:groupexp/view_model/util.dart';

import '../model/billing.dart';
import '../model/choice.dart';
import '../model/debt.dart';
import '../model/party.dart';
import '../model/record.dart';
import '../model/result.dart';
import '../services/http/billing_service.dart';
import '../services/http/parties_service.dart';


class PartyDetailViewModel extends ChangeNotifier {
  final BillingService service = BillingService();
  final partiesService = PartiesService();

  late Party party;
  late Billing billing;

  List<Record> records = [];
  List<int> quantities = [];
  List<Contribution> contributions = [];
  List<Choice> choices = [];
  List<Debt> debts = [];
  List<ChangeDebt> changeDebts = [];


  bool get loading => _state == NotifierState.loading;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void setParty(Party party) {
    this.party = party;
  }

  void getQuantities() {
    List<Record> choicesRecords = choices.map((choice) => choice.record).toList();
    quantities = records.map((e) => 0).toList();
    records.asMap().forEach((index, value) {
      if (choicesRecords.contains(value)) {
        int idx = choicesRecords.indexOf(value);
        quantities[index] = choices[idx].quantity;
      } else {
        quantities[index] = 0;
      }
    });
  }

  Future updateBillingData() async {
    records = billing.records.records;
    contributions = billing.contributions.contributions;
    choices = await service.getChoices(billing);
    getQuantities();
    debts = [];
    changeDebts = [];
  }

  Future setBilling(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      billing = await service.getBilling(party.billingId);
      await updateBillingData();

    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

  Future updateBilling(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      billing = await service.updateBilling(billing);
      await updateBillingData();

    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

  Future contribute(BuildContext context, Contribution contribution) async {
    setState(NotifierState.loading);
    try {
      await service.contribute(contribution);
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

  Future deleteContribution(BuildContext context, int index) async {
    setState(NotifierState.loading);
    try {
      await service.deleteContribution(contributions[index].id);
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

  List<Choice> getChoices() {
    List<Choice> choices = [];
    records.asMap().forEach((index, value) {
      if (quantities[index] > 0) {
        Choice choice = Choice(quantities[index], records[index], billing.id);
        choices.add(choice);
      }
    });
    return choices;
  }

  Future createChoices(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      List<Choice> userChoices = getChoices();
      await service.createChoices(billing.id, userChoices);
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }

  Future getResult(BuildContext context) async {
    setState(NotifierState.loading);
    try {
      Result result = await service.getResult(billing.id);
      debts = result.debts;
      changeDebts = result.changeDebts;
    } on Failure catch (f) {
      setState(NotifierState.failed);
      showInSnackBar(f.toString(), context);
    }
    setState(NotifierState.loaded);
  }
}