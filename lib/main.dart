import 'package:flutter/material.dart';
// import 'package:groupexp/controllers/login_controller.dart';
import 'package:groupexp/screens/login_page.dart';
import 'package:groupexp/services/http/login_services.dart';
import 'package:groupexp/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  var services = LoginService();
  // var controller = LoginController(services);

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
        create: (_) => LoginViewModel(),
        child: const LoginPage(),
      )
    );
  }
}

