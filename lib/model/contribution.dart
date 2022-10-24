class Contribution{
  final int id;
  final String user;
  final int billingId;
  final int contribution;

  Contribution(this.billingId, this.contribution, {this.id=0, this.user="None"});

  Contribution.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        billingId = json['billing'],
        contribution = json['contribution'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user,
    'contribution': contribution,
    'billing': billingId
  };

}

class ContribList{
  final List<Contribution> contributions;

  ContribList({required this.contributions});

  factory ContribList.fromJson(List<dynamic> parsedJson) {
    List<Contribution> contributions = parsedJson.map((i)=>Contribution.fromJson(i)).toList();
    return ContribList(contributions: contributions);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> contribList = [];
    for (Contribution c in contributions) {
      var contribMap = c.toJson();
      contribList.add(contribMap);
    }
    return contribList;
  }
}
