import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkCalls {
  static const String API_URL =
      "https://script.google.com/macros/s/AKfycbxHccPm0ZnO_IzbAjZGofcn_K463i7HS2M6yTx4hL9XdWsRQ0SIOTpccYLrZzRWG5tH/exec";

  // null if server-error in api, else as returned by api
  static signIn(String email, String password) async {
    String finalUrl = "$API_URL?email=$email&password=$password";
    try {
      return await http.get(Uri.parse(finalUrl)).then((response) async {
        print(
            "response is ${response.statusCode}  ${response.body} and headers: ${response.headers}");
        var jsonRes = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (jsonRes["status"] == "SUCCESS" && jsonRes["authorised"] == true)
            return true;
          else
            return false;
        } else {
          print("Email-verification-api : some internal error!");
          return null;
        }
      });
    } catch (e) {
      print("error: $e");
    }
    return null;
  }
}
