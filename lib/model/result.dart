import 'package:groupexp/model/change_debt.dart';
import 'package:groupexp/model/debt.dart';

class Result{
  final List<Debt> debts;
  final List<ChangeDebt> changeDebts;

  Result(this.debts, this.changeDebts);

  Result.fromJson(Map<String, dynamic> json)
      : debts = DebtList.fromJson(json['debts']).debts,
        changeDebts = ChangeDebtList.fromJson(json['change']).debts;
}