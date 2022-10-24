import 'dart:async';
import 'dart:convert';
import 'package:groupexp/exceptions/auth_error.dart';
import 'package:groupexp/exceptions/failure.dart';
import 'package:groupexp/model/user.dart';
import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';

class AuthService extends HttpService{
  Future<String> login(User user) async {
    return await tryRequest(() async {
      final response = await client.post(
          Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(user.toJson())
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String token = body['auth_token'];
        return token;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        HttpResponseError error = HttpResponseError.fromJson(body);
        throw Failure(error.toString());
      }
    });
  }

  Future<User> register(User user) async {
    return await tryRequest(() async {
      final response = await client.post(
          Uri.parse(registerUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(user.toJson())
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User u = User.fromJson(body);
        return u;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        HttpResponseError error = HttpResponseError.fromJson(body);
        throw Failure(error.toString());
      }
    });
  }

  Future<void> logout() async {
    return await tryRequestWithToken((String token) async {
      await client.post(
          Uri.parse(logoutUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ' + token,
          },
      ).timeout(const Duration(seconds: 5));
    });
  }
}