import 'package:aksi_seru_app/models/post_model.dart';

import '../controller/post_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeUnlikePost extends GetxController {
  RxBool likeState = false.obs;
  String currentUserEmail = '';

  Future<void> initializeLikeState(List<dynamic> likes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserEmail = prefs.getString("email") ?? '';
    likeState.value = likes.any((like) {
      LikeModel likeData = like;
      return likeData.email == currentUserEmail;
    });
  }

  RxBool get isLiked => likeState;

  void setLikeUnlike({String? idPost}) {
    likeState.value = !likeState.value;
    if (likeState.value) {
      PostController.likePost(idPost: idPost);
    } else {
      PostController.unlikePost(idPost: idPost);
    }
  }
}
