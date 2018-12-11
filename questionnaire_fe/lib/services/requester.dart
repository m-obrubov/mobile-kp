import 'dart:convert';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rest.dart';
import 'package:questionnaire_fe/constants.dart';

SharedPreferences prefs;

class AuthService {

  static Future<bool> auth(String login, String password) async {
    var response = await RestClient.get(RestPaths.TOKEN, params: { "login" : login, "password" : password });
    if (response.statusCode == 200) {
      var tokenJson = json.decode(response.body)["token"];
      String token = tokenJson["token"];
      int lifetime = tokenJson["lifetime"];
      String role = tokenJson["role"];
      DateTime currentDateTime = DateTime.now();
      prefs.setString("token", token);
      prefs.setInt("tokenLifetime", lifetime);
      prefs.setString("role", role);
      prefs.setString("tokenСomingTime", currentDateTime.toString());
      return true;
    } else {
      return false;
    }
  }

  static void logout()  {
    prefs.remove("token");
    prefs.remove("tokenLifetime");
    prefs.remove("role");
    prefs.remove("tokenСomingTime");
  }

  static bool isAuthenticated()  {
    int tokenLifeTime = prefs.getInt("tokenLifetime");
    String tokenComingTime = prefs.getString("tokenСomingTime");
    if (tokenComingTime != null && tokenLifeTime != null) {
      bool nonExpired = (DateTime.parse(tokenComingTime).difference(DateTime.now()).inMinutes < tokenLifeTime);
      if(nonExpired) return true;
    }
    return false;
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

  //Записать ответ на сервер и получить результат тестирования
  static Future<ResultTest> getResult() async {
    final response = await RestClient.post(RestPaths.RESULT);
    if (response.statusCode == 200){
      return ResultTest.fromJson(json.decode(response.body));
    }
    return null;

  }
}
