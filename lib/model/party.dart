import 'package:groupexp/model/user.dart';

class Party {
  final int id;
  final String name;
  final User host;
  final UsersList members;
  final int billingId;

  Party(this.members, this.name, {this.host = const User(), this.id = 0, this.billingId = 0});

  Party.fromJson(Map<String, dynamic> json)
    : host = User.fromJson(json['host']),
      id = json['id'],
      name = json['name'],
      billingId = json['billing'],
      members = UsersList.fromJson(json['members']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'host': host.toJson(),
    'members': members.toJson(),
    'billingId': billingId
  };
}


class PartiesList {
  final List<Party> parties;

  PartiesList({
    required this.parties,
  });

  factory PartiesList.fromJson(List<dynamic> parsedJson) {
    List<Party> parties = parsedJson.map((i)=>Party.fromJson(i)).toList();
    return PartiesList(parties: parties);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> partiesList = [];
    for (Party party in parties) {
      var partyMap = party.toJson();
      partiesList.add(partyMap);
    }
    return partiesList;
  }
}