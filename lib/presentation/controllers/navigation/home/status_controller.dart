import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialive/Data/models/status_data_model.dart';
import 'package:socialive/Data/models/user_status_data_model.dart';
import 'package:socialive/Data/models/user_profile_model.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/home/status_share_screen.dart';

final ProfileController profileController = Get.find<ProfileController>();

class StatusController extends GetxController {
  RxMap<String, StatusUserProfile> followingProfiles =
      <String, StatusUserProfile>{}.obs;
  RxList<String> statuses = [''].obs;

  Rx<Color> dominantColor = AppColors.activeBottomNevItemColor.obs;

  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAllStatus();
  }

  void fetchAllStatus() {
    ever(profileController.userProfile, (UserProfile? userProfile) {
      if (userProfile != null) {
        fetchFollowingProfiles(userProfile.following!);
      }
    });
    final userProfile = profileController.userProfile.value;
    if (userProfile != null) {
      fetchFollowingProfiles(userProfile.following!);
    }
    getCurrentUserStatus();
  }

  Future<void> fetchFollowingProfiles(List<String> following) async {
    try {
      followingProfiles.clear();

      for (String uid in following) {
        if (uid.isNotEmpty) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('status')
              .snapshots()
              .listen((querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              final statusImages = querySnapshot.docs
                  .expand((doc) => Status.fromFirestore(doc).statusImages)
                  .toList();

              final profileRef =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              final docSnapshot = await profileRef.get();

              if (docSnapshot.exists && docSnapshot.data() != null) {
                final data = docSnapshot.data()!;
                final statusUserProfile = StatusUserProfile(
                  uid: uid,
                  name: data['name'] ?? '',
                  profileImage: data['profileImage'] ?? '',
                  status: statusImages,
                );

                if (statusUserProfile.status.isNotEmpty) {
                  followingProfiles[uid] = statusUserProfile;
                } else {
                  followingProfiles.remove(uid);
                }
              } else {
                followingProfiles.remove(uid);
              }
            } else {
              followingProfiles.remove(uid);
            }
          });
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to fetch profiles and statuses. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }

  void setSelectedImage(File image) {
    selectedImage.value = image;
  }

  void statusUploadFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setSelectedImage(File(pickedFile.path));
    }
    Get.back();
    if (selectedImage.value!.path.isNotEmpty) {
      Get.to(() => StatusShareScreen(
            statusImage: selectedImage.value!.path,
          ));
    }
  }

  void statusUploadFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setSelectedImage(File(pickedFile.path));
    }
    Get.back();
    if (selectedImage.value!.path.isNotEmpty) {
      Get.to(() => StatusShareScreen(
            statusImage: selectedImage.value!.path,
          ));
    }
  }

  Future<void> getCurrentUserStatus() async {
    final uid = profileController.uid;
    if (uid.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('status')
          .snapshots()
          .listen((querySnapshot) {
        final statusImages = querySnapshot.docs
            .map((doc) {
              final status = Status.fromFirestore(doc);
              return status.statusImages.isNotEmpty ? status.statusImages : [];
            })
            .expand((list) => list)
            .toList();

        statuses.value = statusImages.cast<String>();
      });
    }
  }

  Future<void> updateDominantColor(String imageUrl) async {
    try {
      final imageProvider = NetworkImage(imageUrl);
      final paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);

      dominantColor.value =
          paletteGenerator.dominantColor?.color ?? Colors.transparent;
    } catch (e) {
      dominantColor.value = Colors.transparent;
    }
  }
}
