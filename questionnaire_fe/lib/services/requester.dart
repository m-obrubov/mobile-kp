import 'dart:convert';
import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:questionnaire_fe/domain/user.dart';
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
      prefs.setString(StorageDataNames.TOKEN, token);
      prefs.setInt(StorageDataNames.TOKEN_LIFETIME, lifetime);
      prefs.setString(StorageDataNames.ROLE, role);
      prefs.setString(StorageDataNames.TOKEN_COMING_TIME, currentDateTime.toString());
      return true;
    } else {
      return false;
    }
  }

  static void logout()  {
    prefs.remove(StorageDataNames.TOKEN);
    prefs.remove(StorageDataNames.TOKEN_LIFETIME);
    prefs.remove(StorageDataNames.ROLE);
    prefs.remove(StorageDataNames.TOKEN_COMING_TIME);
  }

  static bool isAuthenticated()  {
    int tokenLifeTime = prefs.getInt(StorageDataNames.TOKEN_LIFETIME);
    String tokenComingTime = prefs.getString(StorageDataNames.TOKEN_COMING_TIME);
    if (tokenComingTime != null && tokenLifeTime != null) {
      bool nonExpired = (DateTime.parse(tokenComingTime).difference(DateTime.now()).inMinutes < tokenLifeTime);
      if(nonExpired) return true;
    }
    return false;
  }

  static Role getRole() {
    return Role.fromValue(prefs.getString(StorageDataNames.ROLE));
  }
}

class DataProvider {

  static Future<void> loadTest() async {
    final response = await RestClient.get(RestPaths.GET_TEST);
    if (response.statusCode == 200) {
      String jsonTest = response.body;
      prefs.setString(StorageDataNames.TEST, jsonTest);
      return Test.fromJson(json.decode(jsonTest));
    } else {
      return null;
    }
  }

  static Test getTestFromStorage() {
    String jsonTest = prefs.getString(StorageDataNames.TEST);
    if(jsonTest == null) {
      return null;
    }
    return Test.fromJson(json.decode(jsonTest));
  }

  static Future<bool> register(User user) async {
    final response = await RestClient.post(RestPaths.REGISTER,
        body: json.encode(user.toJsonRegister()),
        contentType: Http.JSON_CONTENT_TYPE
    );
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Записать ответ на сервер и получить результат тестирования
  static Future<ResultTest> getResult(List<QuestionWithAnswers> result, int idTest) async {

    final response = await RestClient.post(RestPaths.RESULT,
        body: json.encode(QuestionWithAnswers.toJsonResult(result, idTest)),
        contentType: Http.JSON_CONTENT_TYPE,
        auth: true
    );
    if (response.statusCode == 200){
      return ResultTest.fromJson(json.decode(response.body));
    }
    return null;
  }
}