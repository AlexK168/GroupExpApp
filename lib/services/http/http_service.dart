import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptions/auth_error.dart';
import '../../exceptions/failure.dart';

class HttpService {
  Client client = Client();
  Future<R> tryRequest<R>(Future<R> Function() body) async {
    try {
      return await body();
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Internal error");
    } on FormatException {
      throw Failure("Format Internal error");
    } on TimeoutException {
      throw Failure("Server not responding. Please, try later");
    } on HttpResponseError catch(err){
      throw Failure(err.toString());
    }
  }

  Future<R> tryRequestWithToken<R>(Future<R> Function(String token) body) async {
    try {
      String token = await getToken();
      if (token == "") {
        throw Failure("You are logged off. Please, log in");
      }
      return await body(token);
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Internal error");
    } on FormatException {
      throw Failure("Format Internal error");
    } on TimeoutException {
      throw Failure("Server not responding. Please, try later");
    } on HttpResponseError catch(err){
      throw Failure(err.toString());
    }
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");
    return token;
  }
}

