import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialive/Data/models/user_profile_model.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/edit_profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/edit_profile_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

final EditProfileController _editProfileController =
    Get.put(EditProfileController());

class ProfileController extends GetxController {
  RxBool showIncompleteProfileDialog = false.obs;
  String uid = '';
  Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  bool isGridViewSelected = true;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  Future<void> initializeUser() async {
    await _getUserUid();
    if (uid.isNotEmpty) {
      _checkUserProfile();
    }
  }

  void clickOnGridView() {
    if (!isGridViewSelected) isGridViewSelected = true;
    update();
  }

  void clickOnListView() {
    if (isGridViewSelected) isGridViewSelected = false;
    update();
  }

  Future<void> _getUserUid() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
  }

  Future<void> _checkUserProfile() async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    userDoc.snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        userProfile.value = UserProfile.fromDocumentSnapshot(docSnapshot);

        if (userProfile.value!.userName!.isEmpty ||
            userProfile.value!.profileImage!.isEmpty) {
          showIncompleteProfileDialog.value = true;
        }
      }
    });
  }

  void showIncompleteProfileAlert() {
    if (showIncompleteProfileDialog.value) {
      showAlertDialog(
        topIcons: Image.asset(AssetsPath.editProfile),
        title: "Profile created",
        content: "Update your name, profile image, and additional number.",
        barrierDismissible: false,
        skipBtn: true,
        elevatedBtnName: "Update",
        onElevatedBtnPressed: () => Get.to(() => const EditProfileScreen()),
      );
      showIncompleteProfileDialog.value = false;
    }
  }

  Future<void> updateUserProfile() async {
    try {
      loadingController.showLoading();

      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

      String? imageUrl;

      final selectedImage = _editProfileController.selectedImage.value;

      if (selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(selectedImage);
        final snapshot = await uploadTask.whenComplete(() {});
        imageUrl = await snapshot.ref.getDownloadURL();
      } else {
        imageUrl = userProfile.value!.profileImage;
      }

      await userDoc.update({
        'name': _editProfileController.nameController.text.isEmpty
            ? userProfile.value!.name
            : _editProfileController.nameController.text,
        'userName': _editProfileController.userNameController.text.isEmpty
            ? userProfile.value!.userName
            : _editProfileController.userNameController.text.toLowerCase(),
        'profileImage': imageUrl,
      });

      loadingController.hideLoading();
      Get.snackbar(
        'Success',
        'Account updated successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Update Failed',
        'Failed to update profile. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }
}
