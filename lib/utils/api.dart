class ApiEndPoints {
  static String baseUrl = 'https://apitubesmppl.000webhostapp.com/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerWithEmail = 'api/users/register.php';
  final String loginWithEmail = 'api/users/login.php';
}

class UserEndPoints {
  static String currentUser = 'api/users/current.php';
  static String updateUserProfile = 'api/users/profile.php';
}
