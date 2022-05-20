import 'package:flutter/material.dart';
import 'package:groupexp/screens/register_page.dart';
import 'package:groupexp/view_model/login_view_model.dart';
import 'package:groupexp/widgets/email_field.dart';
import 'package:groupexp/widgets/password_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../services/pass_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  PassValidator validator = PassValidator(onlyEmptyValidation: true);

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isFormValid() {
    return _isPasswordValid && _isEmailValid;
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    viewModel.setEmailController(emailController);
    viewModel.setPassController(passController);

    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(),
      inAsyncCall: viewModel.loading,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                EmailFormField(
                  textEditingController: emailController,
                  onValidated: (isValid) {
                    setState(() {
                      _isEmailValid = isValid;
                    });
                  },
                ),
                const SizedBox(height: 12.0),
                PasswordFormField(
                  textEditingController: passController,
                  onValidated: (isValid) {
                    setState(() {
                      _isPasswordValid = isValid;
                    });
                  },
                  validateFunc: validator.validate),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed:  isFormValid() ? () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<LoginViewModel>(context, listen: false).login(context);
                    }
                  } : null,
                  child: const Text("Log in")
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (content) => const RegisterPage()));
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
        )
      )
    );
  }
}
