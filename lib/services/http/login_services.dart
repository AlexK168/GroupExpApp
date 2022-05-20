import 'dart:convert';
import 'dart:io';
import 'package:groupexp/exceptions/auth_response_map.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:http/http.dart';

class AuthService {
  Client client = Client();

  // TODO: implement login
  Future<String> login(User user) async {
    try {
      final response = await client.post(
          Uri.parse('http://10.0.2.2:8000/api/v2/login'),
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
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/v2/users'),
      body: jsonEncode(user.toJson())
    );
    return jsonDecode(response.body);
  }
}