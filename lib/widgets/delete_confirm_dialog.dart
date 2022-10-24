import 'package:flutter/material.dart';

Future<T?> showDeleteConfirmDialog<T> (
    BuildContext context,
    {
      required String title,
    }) => showDialog<T>(
    context: context,
    builder: (context) => const DeleteConfirmWidget()
);

class DeleteConfirmWidget extends StatefulWidget {
  const DeleteConfirmWidget({Key? key}) : super(key: key);

  @override
  State<DeleteConfirmWidget> createState() => _DeleteConfirmWidgetState();
}

class _DeleteConfirmWidgetState extends State<DeleteConfirmWidget> {
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Confirm deletion'),
    content: const Text('Delete item?'),
    actions: [
      ButtonBar(
        children: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            child: const Text('Ok')),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'))
        ],
      )
    ],
  );
}
