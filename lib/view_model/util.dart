import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotifierState { initial, loading, loaded, failed }

void showInSnackBar(String value,context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = (prefs.getString('token') ?? "");
  return token;
}
