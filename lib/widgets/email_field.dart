import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final ValueSetter<bool> onValidated;
  const EmailFormField({
    Key? key,
    required this.textEditingController,
    required this.onValidated,
  }) : super(key: key);

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  final _formEmailFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
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
        bool isEmailValid = EmailValidator.validate(value!);
        widget.onValidated(isEmailValid);
        return isEmailValid ? null : 'Please, enter valid email';
      },
      onChanged: (text){
        _formEmailFieldKey.currentState!.validate();
      },
      controller: widget.textEditingController,
    );
  }
}
