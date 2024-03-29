import 'package:flutter/material.dart';
import 'package:groupexp/services/pass_validator.dart';
import 'package:groupexp/view_model/register_view_model.dart';
import 'package:groupexp/widgets/email_field.dart';
import 'package:groupexp/widgets/password_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _formUsernameFieldKey = GlobalKey<FormFieldState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _isUsernameValid = false;
  PassValidator validator = PassValidator(
    min:8,
    max:15,
    digits: 1,
    specialNum: 1,
    lowercase: 1,
    uppercase: 1,
    specialChars: r'!@#$%^&*(),.?":{}|<>'
  );

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isFormValid() {
    return _isPasswordValid && _isEmailValid && _isUsernameValid;
  }

  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    viewModel.emailController = emailController;
    viewModel.passController = passController;
    viewModel.usernameController = usernameController;
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
                  _buildUserName(),
                  const SizedBox(height: 12.0),
                  PasswordFormField(
                    textEditingController: passController,
                    onValidated: (isValid) {
                      setState(() {
                        _isPasswordValid = isValid;
                      });
                    },
                    validateFunc: validator.validate,
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed:  isFormValid() ? () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.register(context);
                      }
                    } : null,
                    child: const Text("Register")
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Already have an account? Log in",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        )
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      key: _formUsernameFieldKey,
      keyboardType: TextInputType.name,
      autocorrect: false,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: UnderlineInputBorder(),
        labelText: 'Username',
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username can't be empty";
        }
        return null;
      },
      onChanged: (text){
        setState(() {
          if (_formUsernameFieldKey.currentState!.validate()) {
            _isUsernameValid = true;
          } else {
            _isUsernameValid = false;
          }
        });
      },
      controller: usernameController,
    );
  }
}