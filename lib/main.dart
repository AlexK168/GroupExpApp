import 'package:flutter/material.dart';
import 'package:groupexp/screens/friends_page.dart';
import 'package:groupexp/screens/landing_page.dart';
import 'package:groupexp/screens/login_page.dart';
import 'package:groupexp/screens/main_page.dart';
import 'package:groupexp/screens/parties_page.dart';
import 'package:groupexp/screens/profile_page.dart';
import 'package:groupexp/screens/register_page.dart';
import 'package:groupexp/utils/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final LoginController controller;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        routes: {
          '/main': (context) => const MainPage(),
          '/friends': (context) => const FriendsPage(),
          '/profile': (context) => const ProfilePage(),
          '/parties': (context) => const PartiesPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage()
        },
        title: 'GroupExp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage()
      ),
    );
  }
}

