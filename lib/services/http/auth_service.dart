import 'dart:convert';
import 'dart:io';
import 'package:groupexp/exceptions/auth_error.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:http/http.dart';

class AuthService {
  final String base = "http://10.0.2.2:8000/api/v2/";
  Client client = Client();

  Future<String> login(User user) async {
    try {
      final response = await client.post(
          Uri.parse(base + 'login'),
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
          Uri.parse(base + 'users'),
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
        print(body);
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