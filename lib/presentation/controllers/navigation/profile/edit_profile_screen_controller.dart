import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ProfileController profileController = Get.find<ProfileController>();

  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeProfileData();
  }

  void _initializeProfileData() {
    final userProfile = profileController.userProfile.value;

    if (userProfile != null) {
      nameController.text = userProfile.name!;
      userNameController.text = userProfile.userName!;
      emailController.text = userProfile.email!;
    }
  }

  String getNameHint() =>
      _getHint(profileController.userProfile.value?.name, 'Input Name');
  String getUserNameHint() => _getHint(
      profileController.userProfile.value?.userName, 'Input User Name');
  String getEmailHint() =>
      _getHint(profileController.userProfile.value?.email, 'Input User Email');

  String _getHint(String? value, String defaultHint) {
    return value?.isNotEmpty == true ? value! : defaultHint;
  }

  void setSelectedImage(File image) {
    selectedImage.value = image;
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }

  void profilePictureUploadFromCamera() async {
    Get.back();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setSelectedImage(File(pickedFile.path));
    }
  }

  void profilePictureUploadFromGallery() async {
    Get.back();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setSelectedImage(File(pickedFile.path));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    clearSelectedImage();
  }
}
