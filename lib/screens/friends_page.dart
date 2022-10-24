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

  Future _getUsers(BuildContext context) async {
    FriendsViewModel viewModel = Provider.of<FriendsViewModel>(context, listen: false);
    viewModel.getFriends(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getUsers(context);
    });
  }

  Widget _buildButtons(FriendsViewModel viewModel) {
    return viewModel.selectMode ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 40)
          ),
          onPressed: (){
            viewModel.selectMode = false;
            Navigator.of(context).pop(viewModel.getSelectedUsers());
          },
          child: const Text('Back'),
        ),
        const SizedBox(height: 80,)
      ],
    ): Container();
  }

  @override
  Widget build(BuildContext context) {
    FriendsViewModel viewModel = Provider.of<FriendsViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Friends')),
        drawer: const NavigationDrawer(),
        body: ModalProgressHUD(
          inAsyncCall: viewModel.loading,
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _getUsers(context);
                  },
                  child: ListView.builder(
                      itemCount: viewModel.friends.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onLongPress: () {
                            viewModel.toSelectMode(true);
                            viewModel.select(index);
                          },
                          onTap: () {
                            viewModel.select(index);
                          },
                          child: ListTile(
                            title: Text(viewModel.friends[index].username),
                            trailing: viewModel.selected[index] ? const Icon(Icons.check) : null,
                          ),
                        );
                      }
                  ),
                ),
              ),
              _buildButtons(viewModel),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/friends/users'
            ).then((value) {
              _getUsers(context);
            });
          },
        ),
    );
  }
}


