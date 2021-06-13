class RestClient {
  static final RestClient _restClient = RestClient._internal();
  String _jwtToken;
  int _itemCount;

  String get jwtToken => _jwtToken;
  int get itemCount => _itemCount;

  set jwtToken(String value) {
    _jwtToken = "Bearer " + value;
  }

  set itemCount(int value) {
    _itemCount = value;
  }

  factory RestClient() {
    return _restClient;
  }

  RestClient._internal();
}
