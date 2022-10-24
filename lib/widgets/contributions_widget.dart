import 'package:flutter/material.dart';
import 'package:groupexp/utils/normalize_price.dart';
import 'package:groupexp/widgets/contribution_dialog.dart';
import 'package:groupexp/widgets/delete_confirm_dialog.dart';

import '../model/contribution.dart';

class ContributionsWidget extends StatefulWidget {
  final ValueSetter<int> onCreateContrib;
  final ValueSetter<int> onDeleteItem;
  final List<Contribution> contributions;
  const ContributionsWidget({Key? key, required this.onCreateContrib, required this.contributions, required this.onDeleteItem}) : super(key: key);

  @override
  State<ContributionsWidget> createState() => _ContributionsWidgetState();
}

class _ContributionsWidgetState extends State<ContributionsWidget> {

  Future _deleteRecord(index) async {
    bool confirmation = await showDeleteConfirmDialog(context, title: "Delete record");
    if (confirmation) {
      widget.onDeleteItem(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.contributions.length,
              itemBuilder: (BuildContext context, int index) {
                var item = widget.contributions[index];
                return InkWell(
                  onLongPress: () {
                    _deleteRecord(index);
                  },
                  child: ListTile(
                    title: Text(
                        item.user + " - " + normalizePrice(item.contribution)),
                  ),
                );
              }
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              int? contribution = await showContributionDialog(context, title: "Contribute");
              if (contribution == null) {
                return;
              }
              setState(() {
                widget.onCreateContrib(contribution);
              });
            },
            child: const Text('Contribute')
        )
      ],
    );
  }
}
