import 'package:groupexp/model/user.dart';

class ChangeDebt {
  final int amount;
  final User creditor;

  ChangeDebt(this.amount, this.creditor);

  ChangeDebt.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        creditor = User.fromJson(json['creditor']);

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'creditor': creditor.toJson()
  };
}


class ChangeDebtList{
  final List<ChangeDebt> debts;

  ChangeDebtList({required this.debts});

  factory ChangeDebtList.fromJson(List<dynamic> parsedJson) {
    List<ChangeDebt> debts = parsedJson.map((i)=>ChangeDebt.fromJson(i)).toList();
    return ChangeDebtList(debts: debts);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> list = [];
    for (ChangeDebt changeDebt in debts) {
      var debtMap = changeDebt.toJson();
      list.add(debtMap);
    }
    return list;
  }
}
