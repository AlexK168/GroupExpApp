import 'dart:convert';

import 'package:groupexp/model/choice.dart';
import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';

import '../../exceptions/auth_error.dart';
import '../../model/billing.dart';
import '../../model/contribution.dart';
import '../../model/result.dart';

class BillingService extends HttpService{
  Future<Billing> getBilling(int id) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.get(
        Uri.parse(billingsDetailUrl(id)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Billing billing = Billing.fromJson(body);
        return billing;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future<Billing> updateBilling(Billing billing) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.put(
        Uri.parse(billingsDetailUrl(billing.id)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
        body: jsonEncode(billing.toJson())
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Billing billing = Billing.fromJson(body);
        return billing;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(
            jsonDecode(response.body)
        );
        throw error;
      }
    });
  }

  Future<List<Choice>> getChoices(Billing billing) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.get(
          Uri.parse(billingsDetailUrl(billing.id) + '/choices'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ' + token,
          },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Choice> choices = ChoiceList.fromJson(body).choices;
        return choices;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future createChoices(int id, List<Choice> choices) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.post(
        Uri.parse(billingsDetailUrl(id) + '/choices'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
        body: jsonEncode(ChoiceList(choices: choices).toJson())
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future contribute(Contribution contribution) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.post(
          Uri.parse(contribUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ' + token,
          },
          body: jsonEncode(contribution.toJson())
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future deleteContribution(int id) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.delete(
          Uri.parse(contribsDetailUrl(id)),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token ' + token,
          },
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future<Result> getResult(int id) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.post(
        Uri.parse(billingsDetailUrl(id) + '/calculate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.fromJson(body);
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }
}
