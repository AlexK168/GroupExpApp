import 'package:flutter/material.dart';

enum NotifierState { initial, loading, loaded, failed }

void showInSnackBar(String value,context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
}

