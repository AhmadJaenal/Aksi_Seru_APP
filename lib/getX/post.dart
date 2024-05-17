import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/models/post_model.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class LikeUnlikePost extends GetxController {
  RxBool likeState = false.obs;

  RxBool get isLiked => likeState;

  void setLikeUnlike({int? id}) {
    if (likeState.value) {
      developer.log('unlike');
      PostController.unLikePost(id: id);
    } else {
      developer.log('like');
      PostController.likePost(id: id);
    }
    likeState.value = !likeState.value;
  }
}

class CommentState extends GetxController {
  var comment = <CommentModel>[].obs;

  int get length => comment.length;

  void setComment(List<CommentModel> userComment) {
    comment.assignAll(userComment);
  }

  void addComment(CommentModel newComment) {
    comment.add(newComment);
  }
}
