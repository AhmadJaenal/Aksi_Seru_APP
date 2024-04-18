class ApiEndPoints {
  static String baseUrl = 'https://apitubesmppl.000webhostapp.com/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerWithEmail = 'api/users/register';
  final String loginWithEmail = 'api/users/login';
}

class User {
  static String currentUser = 'api/users/current';
}
