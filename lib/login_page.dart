import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formEmailFieldKey = GlobalKey<FormFieldState>();
  final _formPassFieldKey = GlobalKey<FormFieldState>();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmail(),
              const SizedBox(height: 12.0),
              _buildPassword(),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Log in")),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      key: _formEmailFieldKey,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: UnderlineInputBorder(),
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (EmailValidator.validate(value!)) {
          return null;
        }
        return 'Please, enter valid email';
      },
      onChanged: (text){
        _formEmailFieldKey.currentState!.validate();
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      key: _formPassFieldKey,
      obscureText: _obscured,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: const UnderlineInputBorder(),
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: GestureDetector(
            onTap: togglePassVisibility,
            child: Icon(
              _obscured
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              size: 24,
            ),
          )
      ),
      validator: (value) {
        RegExp oneUpperCase = RegExp(r'[A-Z]');
        RegExp oneLowerCase = RegExp(r'[a-z]');
        RegExp oneDigit = RegExp(r'[0-9]');
        RegExp oneSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
        if (value == null || value.isEmpty) {
          return "Password can't be empty";
        } else
        if (!oneLowerCase.hasMatch(value)) {
          return 'Password has to contain at least one lower case letter';
        } else
        if (!oneUpperCase.hasMatch(value)) {
          return 'Password has to contain at least one upper case letter';
        } else
        if (!oneDigit.hasMatch(value)) {
          return 'Password has to contain at least one digit';
        } else
        if (!oneSpecialChar.hasMatch(value)) {
          return 'Password has to contain at least one special character';
        } else
        if(value.length < 6 || value.length > 20) {
          return 'Password has to be 6-20 characters long';
        } else
        if (value.contains(' ')) {
          return "Password can't contain spaces";
        }
        return null;
      },
      onChanged: (text) {
        _formPassFieldKey.currentState!.validate();
      },

    );
  }
  void togglePassVisibility() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, don't unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
}
