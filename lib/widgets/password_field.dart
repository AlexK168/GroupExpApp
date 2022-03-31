import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {

  final TextEditingController textEditingController;
  final bool validateOnChanged;
  final ValueSetter<bool> onValidated;
  final String Function(String? value) validateFunc;

  const PasswordFormField({
    Key? key,
    required this.textEditingController,
    this.validateOnChanged = true,
    required this.onValidated,
    required this.validateFunc,

  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  final _formPassFieldKey = GlobalKey<FormFieldState>();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
        String validationMsg = widget.validateFunc(value);
        widget.onValidated(validationMsg.isEmpty);
        return validationMsg.isEmpty ? null : validationMsg;
      },
      onChanged: (text) {
        if (widget.validateOnChanged) {
          _formPassFieldKey.currentState!.validate();
        }
      },
      controller: widget.textEditingController,

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
