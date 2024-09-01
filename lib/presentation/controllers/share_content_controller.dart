import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/widget/loading_controller.dart';

class ShareContentController extends GetxController {
  final TextEditingController postTextController = TextEditingController();
  final _profileController = Get.find<ProfileController>();
  final imageSelectionController = Get.find<ImageSelectionController>();
  final loadingController = Get.find<LoadingController>();

  Future<void> shareCurrentUserPosts({required List<File> postImages}) async {
    try {
      loadingController.showLoading();

      // Create a list to store download URLs
      final List<String> downloadUrls = [];

      // Upload each image and get its download URL
      for (final postImage in postImages) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('posts')
            .child(_profileController.uid)
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(postImage);
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      }

      // Create a new post document
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_profileController.uid);
      final postRef = userRef.collection('posts').doc();

      await postRef.set({
        'postImage': downloadUrls,
        'postDescription': postTextController.text,
        'postTime': DateTime.now(),
        'likeCount': 0,
        'commentCount': [],
        'postId': postRef.id,
        'postUserId': _profileController.uid,
      });

      loadingController.hideLoading();
      Get.back();

      Get.snackbar(
        'Success',
        'Post shared successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Failed',
        'Failed to share post. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }

  @override
  void onClose() {
    postTextController.dispose();
    super.onClose();
  }
}
