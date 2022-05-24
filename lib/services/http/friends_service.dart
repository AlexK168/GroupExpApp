import 'dart:convert';
import 'dart:io';

import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';

import '../../exceptions/auth_error.dart';
import '../../exceptions/failure.dart';
import '../../model/user.dart';

class FriendsService extends HttpService{
  Future<List<User>> getFriends(String token) async {
    try {
      final response = await client.get(
          Uri.parse(friendsUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ' + token,
          },
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        UsersList friendsList = UsersList.fromJson(body);
        return friendsList.users;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        AuthError error = AuthError.fromJson(body);
        String errorString = error.toString();
        if (errorString.contains("token")) {
          errorString = "Internal error. Try to re-login to the app";
        }
        throw Failure(errorString);
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