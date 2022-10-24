import 'dart:convert';
import 'package:groupexp/services/http/http_service.dart';
import 'package:groupexp/services/http/urls.dart';
import '../../exceptions/auth_error.dart';
import '../../model/party.dart';

class PartiesService extends HttpService {
  Future<List<Party>> getParties() async {
    return await tryRequestWithToken((token) async {
      final response = await client.get(
        Uri.parse(partiesUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      ).timeout(const Duration(seconds: 5));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        PartiesList parties = PartiesList.fromJson(body);
        return parties.parties;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }

  Future createParty(Party party) async {
    return await tryRequestWithToken((String token) async {
      final response = await client.post(
        Uri.parse(partiesUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
        body: jsonEncode(party.toJson())
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        HttpResponseError error = HttpResponseError.fromJson(jsonDecode(response.body));
        throw error;
      }
    });
  }
}