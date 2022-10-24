import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/record.dart';
import '../view_model/util.dart';

Future<T?> showRecordDialog<T> (
    BuildContext context,
    {
      required String title,
    }) => showDialog<T>(
    context: context,
    builder: (context) => RecordDialogWidget(
      title: title,
    )
);

class RecordDialogWidget extends StatefulWidget {
  final String title;
  const RecordDialogWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<RecordDialogWidget> createState() => _RecordDialogWidgetState();
}

class _RecordDialogWidgetState extends State<RecordDialogWidget> {
  late TextEditingController productController;
  late TextEditingController priceController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    productController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: Column(
      children: [
        TextField(
          controller: productController,
          decoration: const InputDecoration(
            hintText: 'Product name',
          ),
        ),
        TextField(
            controller: quantityController,
            decoration: const InputDecoration(
              hintText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ]
        ),
        TextField(
          controller: priceController,
          decoration: const InputDecoration(
            hintText: 'Price',
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
        )
      ],
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            final String product = productController.text;
            final String quantity = quantityController.text;
            final String price = priceController.text;
            if (product == "" || quantity == "" || price == "") {
              Navigator.of(context).pop();
              showInSnackBar("Fields can't be empty", context);
              return;
            }
            var priceValue = 0.0;
            var quantityValue = 0;
            try {
              priceValue = double.parse(priceController.text) * 100;
              quantityValue = int.parse(quantity);
            } on FormatException {
              Navigator.of(context).pop();
              showInSnackBar("Value is invalid", context);
              return;
            }
            if (quantityValue == 0) {
              quantityValue = 1;
            }
            final Record record = Record(product, quantityValue, priceValue.toInt());
            Navigator.of(context).pop(record);
          } ,
          child: const Text('Ok')
      )
    ],
  );
}
