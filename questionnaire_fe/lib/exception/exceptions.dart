class RestCallException implements Exception {
  final _message;

  RestCallException(this._message);

  String getMessage() {
    return _message['message'];
  }
}