class ApiEndPoints {
  static String baseUrl = 'http://192.168.160.106/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerWithEmail = 'API_Aksi_Seru/api/users/register.php';
  final String loginWithEmail = 'API_Aksi_Seru/api/users/login.php';
}

class UserEndPoints {
  static String currentUser = 'API_Aksi_Seru/api/users/current.php';
  static String updateUserProfile = 'API_Aksi_Seru/api/users/profile.php';
  static String randomUser = 'API_Aksi_Seru/api/users/random-users.php';
  static String followUser = 'API_Aksi_Seru/api/users/follow.php';
  static String unFollowUser = 'API_Aksi_Seru/api/users/unfollow.php';
  static String deleteFollowers = 'API_Aksi_Seru/api/users/delete-follower.php';
  static String listFollowing = 'API_Aksi_Seru/api/users/list-following.php';
  static String listFollowers = 'API_Aksi_Seru/api/users/list-followers.php';
  static String searchUser = 'API_Aksi_Seru/api/users/search.php';
}

class Story {
  static String createStory = 'API_Aksi_Seru/api/story/create.php';
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
