class Record{
  final int id;
  final String product;
  final int quantity;
  final int price;
  final int billingId;

  Record(this.product, this.quantity, this.price, {this.billingId = 0, this.id = 0,});

  Record.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product = json['product'],
        quantity = json['quantity'],
        price = json['price'],
        billingId = json['billing'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product,
    'quantity': quantity,
    'price': price,
    'billing': billingId
  };

  @override
  bool operator ==(Object other) {
    return other is Record &&
        id == other.id;
  }
}

class RecordList{
  final List<Record> records;

  RecordList({required this.records});

  factory RecordList.fromJson(List<dynamic> parsedJson) {
    List<Record> records = parsedJson.map((i)=>Record.fromJson(i)).toList();
    return RecordList(records: records);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> recordsList = [];
    for (Record record in records) {
      var recordMap = record.toJson();
      recordsList.add(recordMap);
    }
    return recordsList;
  }
}
