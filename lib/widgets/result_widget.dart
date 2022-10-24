import 'package:flutter/material.dart';
import 'package:groupexp/utils/normalize_price.dart';

import '../model/change_debt.dart';
import '../model/debt.dart';

class ResultWidget extends StatefulWidget {
  final VoidCallback onResult;
  final List<Debt> debts;
  final List<ChangeDebt> changeDebts;
  const ResultWidget({
    Key? key,
    required this.onResult,
    required this.debts,
    required this.changeDebts
  }) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: ListView.builder(
              itemCount: widget.debts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      widget.debts[index].debtor.username +
                          ' to ' +
                          widget.debts[index].creditor.username +
                          ': ' +
                          normalizePrice(widget.debts[index].amount)
                  ),
                );
              },
            ),
        ),
        Flexible(
            child: ListView.builder(
              itemCount: widget.changeDebts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      'From change to ' +
                          widget.changeDebts[index].creditor.username +
                          ': ' +
                          normalizePrice(widget.changeDebts[index].amount)
                  ),
                );
              },
            ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onResult();
          },
          child: const Text('Calculate'))
      ],
    );
  }
}
