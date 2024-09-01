import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';

final ProfileController _profileController = Get.find();

class StatusViewScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController progressController;
  Rx<double> progress = 0.0.obs;
  RxInt currentIndex = 0.obs;
  final List<String> statusImages;
  StatusViewScreenController(this.statusImages);
  @override
  void onInit() {
    super.onInit();
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addListener(() {
        progress.value = progressController.value;
        if (progressController.isCompleted) {
          showNextImage();
        }
      });
    startProgress();
  }

  void startProgress() {
    progressController.forward(from: 0.0);
  }

  void showNextImage() {
    if (currentIndex.value < statusImages.length - 1) {
      currentIndex.value++;
      startProgress();
    } else {
      Get.back();
    }
  }

  void holdProgress() {
    if (progressController.isAnimating) {
      progressController.stop();
    }
  }

  void resumeProgress() {
    if (!progressController.isAnimating) {
      progressController.forward();
    }
  }

  Future<void> deleteStatus({required String statusImage}) async {
    try {
      loadingController.showLoading();

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_profileController.uid)
          .collection('status')
          .where('statusImages', arrayContains: statusImage)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.reference;
        } else {
          throw Get.snackbar(
            'Failed',
            'Status with image not found',
            backgroundColor: AppColors.errorColor,
            colorText: AppColors.foregroundColor,
          );
        }
      });

      final documentReference = await docRef;

      final documentSnapshot = await documentReference.get();
      final data = documentSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> statusImages = data['statusImages'];

      if (statusImages.length == 1) {
        await documentReference.delete();
        loadingController.hideLoading();
        Get.back();
      } else {
        await documentReference.update({
          'statusImages': FieldValue.arrayRemove([statusImage])
        });
      }

      if (currentIndex.value >= statusImages.length - 1) {
        currentIndex.value = statusImages.length - 1;
      }

      loadingController.hideLoading();
      Get.snackbar(
        'Success',
        'Status deleted successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
    } catch (e) {
      loadingController.hideLoading();
      log(e.toString());
      Get.snackbar(
        'Failed',
        'Failed to delete status. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }

  @override
  void onClose() {
    progressController.dispose();
    super.onClose();
  }
}
