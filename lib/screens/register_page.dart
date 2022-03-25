import 'package:flutter/material.dart';
import 'package:groupexp/widgets/email_field_widget.dart';
import 'package:groupexp/widgets/password_field_widget.dart';

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
              _buildUserName(),
              const SizedBox(height: 12.0),
              PasswordFormField(textEditingController: passController),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Register")),
            ],
          ),
        ),
      ),
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
        _formUsernameFieldKey.currentState!.validate();
      },
      controller: usernameController,
    );
  }
}