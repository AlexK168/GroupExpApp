import 'dart:convert';
import 'dart:io';
import 'package:groupexp/exceptions/auth_error.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';

class AuthService extends HttpService{

  Future<String> login(User user) async {
    try {
      final response = await client.post(
          Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(user.toJson())
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String token = body['auth_token'];
        return token;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        AuthError error = AuthError.fromJson(body);
        throw Failure(error.toString());
      }

    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Internal error");
    } on FormatException {
      throw Failure("Internal error");
    }
  }

  // TODO: implement register
  Future<User> register(User user) async {
    try {
      final response = await client.post(
          Uri.parse(registerUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(user.toJson())
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User u = User.fromJson(body);
        return u;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        AuthError error = AuthError.fromJson(body);
        throw Failure(error.toString());
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Internal error");
    } on FormatException {
      throw Failure("Internal error");
    }
  }
}