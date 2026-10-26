class EndPoints {
  EndPoints._();

  static const String baseUrl = 'https://api.example.com/api/v1/';
  
  // Auth endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String logout = 'auth/logout';
  static const String profile = 'user/profile';
}

class ApiKeys {
  ApiKeys._();

  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer ';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String accept = 'Accept';
}
