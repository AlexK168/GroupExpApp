import 'package:flutter/material.dart';
import 'package:groupexp/view_model/parties_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../widgets/navigation_drawer.dart';


class PartiesPage extends StatefulWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  State<PartiesPage> createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {

  Future _getParties(BuildContext context) async {
    PartiesViewModel viewModel = Provider.of<PartiesViewModel>(context, listen: false);
    viewModel.getParties(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getParties(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    PartiesViewModel viewModel = Provider.of<PartiesViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Parties')),
      drawer: const NavigationDrawer(),
      body: ModalProgressHUD(
          inAsyncCall: viewModel.loading,
          child: RefreshIndicator(
            onRefresh: () async {
              _getParties(context);
            },
            child: ListView.builder(
                itemCount: viewModel.parties.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(viewModel.parties[index].name),
                    ),
                    onTap: () {
                      // party page
                      Navigator.of(context).pushNamed(
                        '/party_detail',
                        arguments: viewModel.parties[index]
                      ).then((value) {
                        _getParties(context);
                      });
                    },
                  );
                }
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
              '/party_new'
          ).then((value) {
            _getParties(context);
          });
        },
      ),
    );
  }
}


