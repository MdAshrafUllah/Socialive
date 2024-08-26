import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';

final ProfileController _profileController = Get.put(ProfileController());

class StatusShareController extends GetxController {
  Future<void> shareStatus({required String statusImage}) async {
    try {
      loadingController.showLoading();
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('status')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(File(statusImage));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_profileController.uid);
      final statusRef =
          userRef.collection('status').doc(DateTime.now().toIso8601String());
      await statusRef.set({
        'statusImages': FieldValue.arrayUnion([downloadUrl]),
        'timestamp': FieldValue.serverTimestamp(),
      });

      loadingController.hideLoading();
      Get.back();
      Get.snackbar(
        'Success',
        'Status Share successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );

      Future.delayed(const Duration(hours: 24), () async {
        await statusRef.delete();
      });
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Failed',
        'Failed to Share Status. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }
}
