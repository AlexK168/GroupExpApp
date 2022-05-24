import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const NavigationDrawer(),
      body: const Text('profile'),
    );
  }
}
