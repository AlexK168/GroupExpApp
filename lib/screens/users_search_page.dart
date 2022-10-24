import 'package:flutter/material.dart';
import 'package:groupexp/view_model/user_search_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class UsersSearchPage extends StatefulWidget {
  const UsersSearchPage({Key? key}) : super(key: key);

  @override
  State<UsersSearchPage> createState() => _UsersSearchPageState();
}

class _UsersSearchPageState extends State<UsersSearchPage> {
  @override
  Widget build(BuildContext context) {
    UsersSearchViewModel viewModel = Provider.of<UsersSearchViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: MySearchDelegate()
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: viewModel.usersToAdd.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        viewModel.removeUserAt(index);
                      },
                      key: UniqueKey(),
                      child: ListTile(
                        title: Text(viewModel.usersToAdd[index].username),
                      )
                    );
                  },
                ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await viewModel.addFriends(context);
                  viewModel.usersToAdd.clear();
                  Navigator.of(context).pop();

                },
                child: const Text("Add"))
          ],
        ),
      )
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
        }
      },
      icon: const Icon(Icons.clear))
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    UsersSearchViewModel viewModel = Provider.of<UsersSearchViewModel>(context);
    return FutureBuilder(
      future: viewModel.getSuggestions(context, query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var suggestions = snapshot.data as List<User>?;
          return ListView.builder(
            itemCount: suggestions?.length,
            itemBuilder: (BuildContext context, int index) {
              final suggestion = suggestions![index];
              return ListTile(
                title: Text(suggestion.username),
                onTap: () {
                  viewModel.addUserToList(context, suggestion);
                },
              );
            },
          );
        } else {
          return Container();
        }
      }
    );
  }
}
