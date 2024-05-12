import 'package:get/get.dart';

class ShowRecommendUserState extends GetxController {
  RxBool showRecommend = true.obs;

  void show() {
    showRecommend.value = !showRecommend.value;
    update();
  }
}
