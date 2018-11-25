import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'rest.dart';
import 'package:questionnaire_fe/constants.dart';

class AuthService {
  static void auth(String login, String password) async {
    try {
      final response = await RestClientNoAuth.get(RestPaths.TOKEN, params: { "login" : login, "password" : password });
      if (response.statusCode == 200) {
        String token = json.decode(response.body)["token"];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
      }
    } catch (e) {

    }
  }

  static Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      final response = await RestClientNoAuth.get(RestPaths.AUTH_CHECK, params: { "token" : token });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}