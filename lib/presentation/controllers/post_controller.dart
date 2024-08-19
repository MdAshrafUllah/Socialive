import 'package:get/get.dart';

class PostController extends GetxController {
  var isLiked = false.obs;
  var isSaved = false.obs;

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }
}
