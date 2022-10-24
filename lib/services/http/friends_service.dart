import 'dart:async';
import 'dart:convert';

import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';

import '../../exceptions/auth_error.dart';
import '../../exceptions/failure.dart';
import '../../model/user.dart';

class FriendsService extends HttpService{
  Future<List<User>> getFriends() async {
    return await tryRequestWithToken((String token) async {
      final response = await client.get(
        Uri.parse(friendsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        UsersList friendsList = UsersList.fromJson(body);
        return friendsList.users;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        HttpResponseError error = HttpResponseError.fromJson(body);
        String errorString = error.toString();
        if (errorString.contains("token")) {
          errorString = "Internal error. Try to re-login to the app";
        }
        throw Failure(errorString);
      }
    });
  }

  Future<void> addFriends(List<User> friends) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.post(
        Uri.parse(friendsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
        body: jsonEncode(UsersList(users: friends).toJson())
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        if (response.body.isEmpty) {
          throw Failure("Internal error");
        }
        var body = jsonDecode(response.body);
        HttpResponseError error = HttpResponseError.fromJson(body);
        String errorString = error.toString();
        if (errorString.contains("token")) {
          errorString = "Internal error. Try to re-login to the app";
        }
        throw Failure(errorString);
      }
    });
  }

  Future<List<User>> getUsers() async {
    return await tryRequestWithToken((String token) async {
      final response = await client.get(
        Uri.parse(usersUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        UsersList usersList = UsersList.fromJson(body);
        return usersList.users;
      } else if (response.statusCode >= 500) {
        throw Failure("Server error");
      }
      else {
        HttpResponseError error = HttpResponseError.fromJson(body);
        String errorString = error.toString();
        if (errorString.contains("token")) {
          errorString = "Internal error. Try to re-login to the app";
        }
        throw Failure(errorString);
      }
    });
  }
}