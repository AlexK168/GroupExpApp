import 'package:flutter/material.dart';
import 'package:groupexp/widgets/delete_confirm_dialog.dart';
import 'package:groupexp/widgets/record_dialog.dart';

import '../model/record.dart';
import '../utils/normalize_price.dart';

class CheckWidget extends StatefulWidget {
  final VoidCallback onSave;
  final List<Record> records;
  const CheckWidget({Key? key, required this.records, required this.onSave}) : super(key: key);

  @override
  State<CheckWidget> createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {

  int _total() {
    return widget.records.fold(0, (prev, element) => prev + element.quantity * element.price);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const <DataColumn> [
                DataColumn(
                  label: Text('Product'),
                ),
                DataColumn(
                  label: Text('Quantity'),
                ),
                DataColumn(
                  label: Text('Price'),
                ),
              ],
              rows: List.generate(widget.records.length, (index) => _getDataRow(index, widget.records))
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text('Total: ' + normalizePrice(_total())),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              _addRecord();
            },
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder()
            ),
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              widget.onSave();
            },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  DataRow _getDataRow(index, records) {
    Record record = records[index];
    String price = normalizePrice(record.price);
    return DataRow(
        onLongPress: () {
          _deleteRecord(index);
        },
        cells: <DataCell>[
          DataCell(
            Text(record.product),
          ),
          DataCell(
              Text(record.quantity.toString())
          ),
          DataCell(
              Text(price)
          ),
        ]
    );
  }

  Future _deleteRecord(index) async {
    bool confirmation = await showDeleteConfirmDialog(context, title: "Delete record");
    if (confirmation) {
      setState(() {
        widget.records.removeAt(index);
      });
    }
  }

  Future _addRecord() async {
    final Record? record = await showRecordDialog(context, title: "Add record");
    if (record == null) {
      return;
    }
    setState(() {
      widget.records.add(record);
    });
  }
}
