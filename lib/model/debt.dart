import 'package:groupexp/model/user.dart';

class Debt {
  final int amount;
  final User debtor;
  final User creditor;

  Debt(this.amount, this.debtor, this.creditor);

  Debt.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        debtor = User.fromJson(json['debtor']),
        creditor = User.fromJson(json['creditor']);

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'debtor': debtor.toJson(),
    'creditor': creditor.toJson()
  };
}


class DebtList{
  final List<Debt> debts;

  DebtList({required this.debts});

  factory DebtList.fromJson(List<dynamic> parsedJson) {
    List<Debt> debts = parsedJson.map((i)=>Debt.fromJson(i)).toList();
    return DebtList(debts: debts);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> list = [];
    for (Debt choice in debts) {
      var debtMap = choice.toJson();
      list.add(debtMap);
    }
    return list;
  }
}
