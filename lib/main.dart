import 'package:flutter/material.dart';
import 'package:groupexp/screens/landing_page.dart';
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
          title: 'GroupExp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LandingPage()
      ),
    );
  }
}

