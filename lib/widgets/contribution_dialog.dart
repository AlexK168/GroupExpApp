import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../view_model/util.dart';

Future<T?> showContributionDialog<T> (
    BuildContext context,
    {
      required String title,
    }) => showDialog<T>(
    context: context,
    builder: (context) => ContributionDialogWidget(
      title: title,
    )
);

class ContributionDialogWidget extends StatefulWidget {
  final String title;
  const ContributionDialogWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<ContributionDialogWidget> createState() => _ContributionDialogWidgetState();
}

class _ContributionDialogWidgetState extends State<ContributionDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    actions: [
      ElevatedButton(
          onPressed: () {
            var contrib = 0.0;
            try {
              contrib = double.parse(controller.text) * 100;
              int contribValue = contrib.toInt();
              Navigator.of(context).pop(contribValue);
            } on FormatException {
              Navigator.of(context).pop();
              showInSnackBar("Value is invalid", context);
            }
          } ,
          child: const Text('Ok')
      )
    ],
    content: TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Contribution',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
        TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.replaceAll(',', '.'),
          ),
        ),
      ],
    ),
  );
}

