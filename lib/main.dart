import 'package:flutter/material.dart';
import 'package:groupexp/screens/register_page.dart';
import 'package:groupexp/view_model/register_view_model.dart';
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
    return MaterialApp(
      title: 'GroupExp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => RegisterViewModel(),
        child: const RegisterPage(),
      )
    );
  }
}

