import 'package:flutter/material.dart';
import 'package:groupexp/screens/parties_page.dart';
import 'package:groupexp/screens/profile_page.dart';
import 'package:groupexp/screens/friends_page.dart';
import 'package:groupexp/widgets/navigation_drawer.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GroupExp'),),
      body: const Center(
        child: Text('MainPage'),
      ),
      drawer: const NavigationDrawer()
    );
  }
}

