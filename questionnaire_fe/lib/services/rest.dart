import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:questionnaire_fe/constants.dart';

class RestClientAuth {
  static Future<http.Response> get(String path, { Map<String, String> params }) async {
    var uri = Uri.http(RestPaths.BASE_URL, path, params);
    return await http.get(uri, headers: { "Authorization" : await _getToken() });
  }

  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}

class RestClientNoAuth {
  static Future<http.Response> get(String path, { Map<String, String> params }) async {
    //TODO
    return await http.get(path);
  }
}