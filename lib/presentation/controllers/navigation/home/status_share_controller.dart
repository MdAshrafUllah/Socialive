import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';

final ProfileController _profileController = Get.find<ProfileController>();

class StatusShareController extends GetxController {
  Future<void> shareStatus({required String statusImage}) async {
    try {
      loadingController.showLoading();
      DateTime now = DateTime.now();
      final formattedDate =
          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('status')
          .child(_profileController.uid)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(File(statusImage));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_profileController.uid);

      final statusQuery = await userRef
          .collection('status')
          .where('date', isEqualTo: formattedDate)
          .get();

      if (statusQuery.docs.isNotEmpty) {
        final existingStatusRef = statusQuery.docs.first.reference;
        await existingStatusRef.update({
          'statusImages': FieldValue.arrayUnion([downloadUrl]),
        });
      } else {
        final statusRef = userRef.collection('status').doc();
        await statusRef.set({
          'statusImages': FieldValue.arrayUnion([downloadUrl]),
          'statusUID': statusRef.id,
          'date': formattedDate,
        });
      }

      loadingController.hideLoading();
      Get.back();
      Get.snackbar(
        'Success',
        'Status Share successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
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
