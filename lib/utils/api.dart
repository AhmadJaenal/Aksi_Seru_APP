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
  static String randomUser = 'api/users/random-users.php';
  static String followUser = 'api/users/follow.php';
  static String unFollowUser = 'api/users/unfollow.php';
  static String listFollowing = 'api/users/list-following.php';
  static String listFollowers = 'api/users/list-following.php';
}
