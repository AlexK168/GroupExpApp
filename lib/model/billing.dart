import 'package:groupexp/model/choice.dart';
import 'package:groupexp/model/record.dart';

import 'contribution.dart';

class Billing {
  final int id;
  final int total;
  final int partyId;
  final RecordList records;
  final ChoiceList choices;
  final ContribList contributions;

  Billing(this.partyId, this.records, this.choices, this.contributions, {this.total=0, this.id = 0});

  Billing.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        total = json['total'],
        partyId = json['party'],
        records = RecordList.fromJson(json['records']),
        choices = ChoiceList.fromJson(json['choices']),
        contributions = ContribList.fromJson(json['contributions']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total,
    'party': partyId,
    'records': records.toJson(),
    'choices': choices.toJson(),
  };
}





