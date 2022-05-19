import 'dart:convert';
import 'dart:io';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:http/http.dart';

class LoginService {
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
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        String token = body['auth_token'];
        return token;
      } else {
        throw Failure(response.body);
      }

    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Http error");
    } on FormatException {
      throw Failure("Bad format");
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