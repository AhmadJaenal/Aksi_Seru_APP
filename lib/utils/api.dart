class ApiEndPoints {
  static String ip = '192.168.160.106';
  static String baseUrl = 'http://$ip/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerWithEmail = 'api/api/users/register.php';
  final String loginWithEmail = 'api/api/users/login.php';
  final String logout = 'api/api/users/logout.php';
}

class UserEndPoints {
  static String currentUser = 'api/api/users/current.php';
  static String updateUserProfile = 'api/api/users/profile.php';
  static String randomUser = 'api/api/users/random-users.php';
  static String followUser = 'api/api/users/follow.php';
  static String unFollowUser = 'api/api/users/unfollow.php';
  static String deleteFollowers = 'api/api/users/delete-follower.php';
  static String listFollowing = 'api/api/users/list-following.php';
  static String listFollowers = 'api/api/users/list-followers.php';
  static String searchUser = 'api/api/users/search.php';
}

class Story {
  static String createStory = 'api/api/story/create.php';
}

// class ApiEndPoints {
//   static String baseUrl = 'https://apitubesmppl.000webhostapp.com/';
//   static _AuthEndPoints authEndPoints = _AuthEndPoints();
// }

// class _AuthEndPoints {
//   final String registerWithEmail = 'api/users/register.php';
//   final String loginWithEmail = 'api/users/login.php';
// }

// class UserEndPoints {
//   static String currentUser = 'api/users/current.php';
//   static String updateUserProfile = 'api/users/profile.php';
//   static String randomUser = 'api/users/random-users.php';
//   static String followUser = 'api/users/follow.php';
//   static String unFollowUser = 'api/users/unfollow.php';
//   static String listFollowing = 'api/users/list-following.php';
//   static String listFollowers = 'api/users/list-followers.php';
//   static String searchUser = 'api/users/search.php';
// }
