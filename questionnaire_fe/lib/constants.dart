class Http {
  static const JSON_CONTENT_TYPE = "application/json";
  static const PLAIN_TEXT_CONTENT_TYPE = "text/plain";

  static const HEADER_CONTENT_TYPE = "Content-Type";
  static const HEADER_AUTHORIZATION = "Authorization";
}

class RestPaths {
  static const BASE_URL = "10.0.2.2:8080";

  static const TOKEN = "/account/token";
  static const REGISTER = "/account/register";

  static const USER_DATA = "/user";

  static const RESULTS_OWN = "/result";
  static const RESULT = "/result"; //получить и записть результат тестирования
  static const RESULT_ALL = "/result/all"; //получить по критериям

  static const GET_TEST = "/test";
}

class StorageDataNames {
  static const TOKEN = "token";
  static const TOKEN_LIFETIME = "tokenLifetime";
  static const TOKEN_COMING_TIME = "tokenСomingTime";
  static const ROLE = "role";
  static const TEST = "test";

}