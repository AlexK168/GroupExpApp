import 'package:flutter/material.dart';
import 'package:groupexp/services/http/auth_service.dart';

import '../exceptions/failure.dart';
import '../view_model/util.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  Future<void> logout(BuildContext context) async {
    AuthService service = AuthService();
    try {
      await service.logout();
      Navigator.of(context).pushReplacementNamed(
          '/login'
      );
    } on Failure catch (f) {
      showInSnackBar(f.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(
                      '/profile'
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_alt),
                title: const Text('Friends'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(
                    '/friends'
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.groups),
                title: const Text('Parties'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(
                      '/parties'
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  Navigator.pop(context);
                  await logout(context);
                },
              ),
            ],
          ),
        )
    );
  }
}
