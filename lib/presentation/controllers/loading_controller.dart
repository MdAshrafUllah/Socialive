import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';

class LoadingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void showLoading() {
    Get.dialog(
      loadingAnimation(),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
