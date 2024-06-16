import 'package:aksi_seru_app/controller/post_controller.dart';

import 'package:get/get.dart';

class LikeUnlikePost extends GetxController {
  RxBool likeState = false.obs;

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
