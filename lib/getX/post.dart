import 'dart:async';

import '../models/article_model.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class LikeUnlikePost extends GetxController {
  RxBool likeState = false.obs;

  RxBool get isLiked => likeState;

  void setLikeUnlike({int? id}) {
    if (likeState.value) {
      developer.log('unlike');
    } else {
      developer.log('like');
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

  void startAutoDeleteTimer() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (comment.isNotEmpty) {
        comment.removeAt(0);
      }
    });
  }
}
