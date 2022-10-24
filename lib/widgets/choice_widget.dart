import 'package:flutter/material.dart';
import 'package:groupexp/widgets/counter_widget.dart';

import '../model/choice.dart';
import '../model/record.dart';

class ChoiceWidget extends StatefulWidget {
  final VoidCallback onSave;
  final List<Record> records;
  final List<Choice> choices;
  final List<int> quantities;
  const ChoiceWidget({
    Key? key,
    required this.onSave,
    required this.records,
    required this.choices,
    required this.quantities
  }) : super(key: key);

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: widget.records.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.records[index].product),
                      CounterWidget(
                        onValueChanged: (int value) {
                          widget.quantities[index] = value;
                        },
                        max: widget.records[index].quantity,
                        min: 0,
                        value: widget.quantities[index])
                    ],
                  );
                }
            )
        ),
        ElevatedButton(
            onPressed: () {
              widget.onSave();
            },
            child: const Text('Save')
        )
      ],
    );
  }
}
