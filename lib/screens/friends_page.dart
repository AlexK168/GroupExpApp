import 'package:flutter/material.dart';
import 'package:groupexp/view_model/friends_view_model.dart';
import 'package:groupexp/widgets/navigation_drawer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {

  void _getUsers(BuildContext context) async {
    FriendsViewModel viewModel = Provider.of<FriendsViewModel>(context, listen: false);
    viewModel.getFriends(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getUsers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    FriendsViewModel viewModel = Provider.of<FriendsViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Friends')),
        drawer: const NavigationDrawer(),
        body: ModalProgressHUD(
          inAsyncCall: viewModel.loading,
          child: viewModel.friends.isNotEmpty ? ListView.builder(
              itemCount: viewModel.friends.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(viewModel.friends[index].username),
                );
              }
          ): const Center(child: Text('No friends yet')),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //TODO: add a friend functionality
          },
        ),
    );
  }
}

