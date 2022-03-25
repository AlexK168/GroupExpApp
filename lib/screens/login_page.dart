import 'package:flutter/material.dart';
import 'package:groupexp/widgets/email_field_widget.dart';
import 'package:groupexp/widgets/password_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailFormField(textEditingController: emailController),
              const SizedBox(height: 12.0),
              PasswordFormField(textEditingController: passController),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // print(passController.text);
                    }
                  },
                  child: const Text("Log in")),
            ]
          ),
        ),
      ),
    );
  }
}
