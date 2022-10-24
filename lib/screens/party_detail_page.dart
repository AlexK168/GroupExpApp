import 'package:flutter/material.dart';
import 'package:groupexp/view_model/party_detail_view_model.dart';
import 'package:groupexp/widgets/check_widget.dart';
import 'package:groupexp/widgets/choice_widget.dart';
import 'package:groupexp/widgets/contributions_widget.dart';
import 'package:groupexp/widgets/result_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../model/contribution.dart';
import '../model/party.dart';

class PartDetailPage extends StatefulWidget {
  const PartDetailPage({Key? key}) : super(key: key);

  @override
  State<PartDetailPage> createState() => _PartDetailPageState();
}

class _PartDetailPageState extends State<PartDetailPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PartyDetailViewModel viewModel = Provider.of<PartyDetailViewModel>(context, listen: false);
      Party party = ModalRoute.of(context)!.settings.arguments as Party;
      viewModel.setParty(party);
      viewModel.setBilling(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    PartyDetailViewModel viewModel = Provider.of<PartyDetailViewModel>(context);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: (){
                    viewModel.updateBilling(context);
                  },
                  icon: const Icon(Icons.refresh))
            ],
            title: const Text('Party details'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Billing',
                ),
                Tab(
                  text: 'Contribute',
                ),
                Tab(
                  text: 'Choose'
                ),
                Tab(
                  text: 'Result',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                margin: const EdgeInsets.all(32),
                child: ModalProgressHUD(
                  inAsyncCall: viewModel.loading,
                  progressIndicator: const CircularProgressIndicator(),
                  child: CheckWidget(
                    records: viewModel.records,
                    onSave: (){
                      viewModel.updateBilling(context);
                    },),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(32),
                child: ModalProgressHUD(
                  inAsyncCall: viewModel.loading,
                  progressIndicator: const CircularProgressIndicator(),
                  child: ContributionsWidget(
                    onDeleteItem: (int index) async {
                      await viewModel.deleteContribution(context, index);
                      await viewModel.updateBilling(context);
                    },
                    onCreateContrib: (int contribution) async {
                      Contribution c = Contribution(viewModel.billing.id, contribution);
                      await viewModel.contribute(context, c);
                      await viewModel.updateBilling(context);
                    },
                    contributions: viewModel.contributions),
                )
              ),
              Container(
                margin: const EdgeInsets.all(32),
                child: ModalProgressHUD(
                  inAsyncCall: viewModel.loading,
                  progressIndicator: const CircularProgressIndicator(),
                  child: ChoiceWidget(
                    quantities: viewModel.quantities,
                    records: viewModel.records,
                    choices: viewModel.choices,
                    onSave: () async {
                      await viewModel.createChoices(context);
                      await viewModel.updateBilling(context);
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(32),
                child: ModalProgressHUD(
                  inAsyncCall: viewModel.loading,
                  progressIndicator: const CircularProgressIndicator(),
                  child: ResultWidget(
                    onResult: () {
                      viewModel.getResult(context);
                    },
                    debts: viewModel.debts,
                    changeDebts: viewModel.changeDebts,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
