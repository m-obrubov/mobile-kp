import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:questionnaire_fe/constants.dart';

class RestClient {
  static Future<http.Response> get(String path, { Map<String, String> params, bool auth = false }) async {
    Uri uri = Uri.http(RestPaths.BASE_URL, path, params);
    if(auth) {
      return await http.get(uri, headers: { Http.HEADER_AUTHORIZATION : await _getToken() });
    } else {
      return await http.get(uri);
    }
  }

  static Future<http.Response> post(String path,
      {
        Map<String, String> params,
        body,
        String contentType = Http.PLAIN_TEXT_CONTENT_TYPE,
        bool auth = false
      }) async {
    var uri = Uri.http(RestPaths.BASE_URL, path, params);
    Map<String, String> headers = { Http.HEADER_CONTENT_TYPE : contentType };
    if(auth) {
      headers[Http.HEADER_AUTHORIZATION] = await _getToken();
    }
    return await http.post(uri, body: body, headers: headers);
  }

  static Future<http.Response> put(String path,
      {
        Map<String, String> params,
        body,
        String contentType = Http.PLAIN_TEXT_CONTENT_TYPE,
        bool auth = false
      }) async {
    var uri = Uri.http(RestPaths.BASE_URL, path, params);
    Map<String, String> headers = { Http.HEADER_CONTENT_TYPE : contentType };
    if(auth) {
      headers[Http.HEADER_AUTHORIZATION] = await _getToken();
    }
    return await http.put(uri, body: body, headers: headers);
  }

  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageDataNames.TOKEN);
  }
}