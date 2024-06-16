import 'package:aksi_seru_app/models/user_model.dart';
import 'package:get/get.dart';

class CounterFollowUser extends GetxController {
  RxInt counterUserFollowing = 0.obs;
  RxInt counterUserFollowers = 0.obs;

  void setCountUserFollow(int count) {
    counterUserFollowing = count.obs;
  }

  void setCountUserFollowers(int count) {
    counterUserFollowers = count.obs;
  }

  void follow() => counterUserFollowing.value++;
  void unfollow() => counterUserFollowing.value--;

  void deleteFollower() => counterUserFollowers.value--;
}

class ListFollowingCounter extends GetxController {
  var userData = <UserModel>[].obs;

  int get length => userData.length;

  void setUserData(List<UserModel> user) {
    userData = user.obs;
  }

  void follow(UserModel user) {
    userData.add(user);
  }

  void unFollow(int id) {
    // userData.removeWhere((user) => user.id == id);
    userData.refresh();
  }
}

class ListFollowersCounter extends GetxController {
  var userData = <UserModel>[].obs;

  int get length => userData.length;

  void setUserData(List<UserModel> user) {
    userData = user.obs;
  }

  void deleteFollowers(int id) {
    // userData.removeWhere((user) => user.id == id);
    userData.refresh();
  }
}
