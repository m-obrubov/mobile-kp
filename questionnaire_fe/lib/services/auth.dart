import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'rest.dart';
import 'package:questionnaire_fe/constants.dart';

class AuthService {
  static Future<bool> auth(String login, String password) async {
    try {
      final response = await RestClient.get(RestPaths.TOKEN, params: { "login" : login, "password" : password });
      if (response.statusCode == 200) {
        String token = json.decode(response.body)["token"];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  static Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if(token == null) {
        return false;
      }
      final response = await RestClient.get(RestPaths.AUTH_CHECK, params: { "token" : token });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}