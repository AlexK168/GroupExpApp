import 'package:flutter/material.dart';
import 'package:groupexp/view_model/create_party_view_model.dart';
import 'package:groupexp/view_model/util.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class CreatePartyPage extends StatefulWidget {
  const CreatePartyPage({Key? key}) : super(key: key);

  @override
  State<CreatePartyPage> createState() => _CreatePartyPageState();
}


class _CreatePartyPageState extends State<CreatePartyPage> {
  final partyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CreatePartyViewModel viewModel = Provider.of<CreatePartyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New party'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: viewModel.loading,
        child: Container(
          margin: const EdgeInsets.all(32),
          child: Column(
            children: [
              TextFormField(
                controller: partyNameController,
                decoration: const InputDecoration(
                    labelText: 'Enter party name'
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Members:'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                '/friends'
                            ).then((value) {
                              if (value != null) {
                                viewModel.addMembers(value as List<User>, context);
                              }
                            });
                          },
                          child: const Text('Add from friends list')
                      ),
                    ],
                  )
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.members.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(viewModel.members[index].username),
                      );
                    },
                  )
              ),
              ElevatedButton(
                  onPressed: (){
                    if (partyNameController.text == "") {
                      showInSnackBar("Fill the party name field", context);
                      return;
                    }
                    viewModel.partyName = partyNameController.text;
                    viewModel.createParty(context);
                  },
                  child: const Text('Create'))
            ],
          ),
        ),
      )
    );
  }
}
