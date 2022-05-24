import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parties')),
      drawer: const NavigationDrawer(),
      body: const Text('parties'),
    );
  }
}
