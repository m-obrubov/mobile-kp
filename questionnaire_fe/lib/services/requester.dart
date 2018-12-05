import 'dart:convert';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rest.dart';
import 'package:questionnaire_fe/constants.dart';

SharedPreferences prefs;

class AuthService {

  static bool auth(String login, String password){
    bool result = false;
    String token;
    int lifetime;
    String role;
    DateTime currentDateTime;
    RestClient.get(RestPaths.TOKEN, params: { "login" : login, "password" : password })
      .then((response) {
        if (response.statusCode == 200) {
          var tokenJson = json.decode(response.body)["token"];
          token = tokenJson["token"];
          lifetime = tokenJson["lifetime"];
          role = tokenJson["role"];
          currentDateTime = DateTime.now();
          result =  true;
        } else {
          result =  false;
        }
        if (token != null) {
          prefs.setString("token", token);
          prefs.setInt("tokenLifetime", lifetime);
          prefs.setString("role", role);
          prefs.setString("tokenСomingTime", currentDateTime.toString());
        }
      });
    return result;
  }

  static void logout()  {
    prefs.remove("token");
    prefs.remove("tokenLifetime");
    prefs.remove("role");
    prefs.remove("tokenСomingTime");
  }

  static bool isAuthenticated()  {
    bool result = false;
    int tokenLifeTime = prefs.getInt("tokenLifetime");
    String tokenComingTime = prefs.getString("tokenСomingTime");
    if (tokenComingTime != null && tokenLifeTime != null && (DateTime.parse(tokenComingTime).millisecondsSinceEpoch+tokenLifeTime*60000) < DateTime.now().millisecondsSinceEpoch){
        result = true;
    }
    return result;
  }
}

class DataProvider {

  static void dropTestStore() {
    prefs.remove('test');
  }

  static Future<Test> getTest() async {
    String jsonTest = prefs.getString('test');
    if(jsonTest == null) {
      final response = await RestClient.get(RestPaths.GET_TEST);
      if (response.statusCode == 200) {
        jsonTest = response.body;
        prefs.setString("test", jsonTest);
      }
      return null;
    }
    return Test.fromJson(json.decode(jsonTest));
  }
}