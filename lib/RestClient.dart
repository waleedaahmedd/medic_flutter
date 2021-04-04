class RestClient {
  static final RestClient _restClient = RestClient._internal();
  String _jwtToken;

  String get jwtToken => _jwtToken;

  set jwtToken(String value) {
    _jwtToken = value;
  }

  factory RestClient() {
    return _restClient;
  }

  RestClient._internal();
}