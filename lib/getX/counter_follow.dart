import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:get/get.dart';

class FollowCounter extends GetxController {
  RxBool isFollow = false.obs;

  bool get getFollowState => isFollow.value;

  void setFollowState({required bool isFollowed}) {
    isFollow.value = isFollowed;
  }

  void setActionFollow({String? email}) {
    if (isFollow.value) {
      UserData.followUser(userFollowed: email);
    } else {
      UserData.unfollowUser(userFollowed: email);
    }
  }
}
