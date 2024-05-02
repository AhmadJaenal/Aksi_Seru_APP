class ApiEndPoints {
  static String baseUrl = 'http://192.168.137.1/api-main/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerWithEmail = 'api/users/register.php';
  final String loginWithEmail = 'api/users/login.php';
}

class User {
  static String currentUser = 'api/users/current.php';
}
