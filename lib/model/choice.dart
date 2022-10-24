
import 'package:groupexp/model/record.dart';

class Choice {
  final int id;
  final int quantity;
  final Record record;
  final int billingId;

  Choice(this.quantity, this.record, this.billingId, {this.id=0});

  Choice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'],
        record = Record.fromJson(json['record']),
        billingId = json['billing'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'quantity': quantity,
    'record': record.toJson(),
    'billing': billingId
  };
}


class ChoiceList{
  final List<Choice> choices;

  ChoiceList({required this.choices});

  factory ChoiceList.fromJson(List<dynamic> parsedJson) {
    List<Choice> choices = parsedJson.map((i)=>Choice.fromJson(i)).toList();
    return ChoiceList(choices: choices);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> choicesList = [];
    for (Choice choice in choices) {
      var choiceMap = choice.toJson();
      choicesList.add(choiceMap);
    }
    return choicesList;
  }
}
