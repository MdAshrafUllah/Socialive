import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';

final ProfileController profileController = Get.put(ProfileController());
final StatusController _statusController = Get.put(StatusController());

Widget currentUserProfilePicture({
  double? minRadius,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _statusController.statuses.isNotEmpty
          ? AppColors.primaryColor
          : AppColors.foregroundColor,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Padding(
      padding: const EdgeInsets.all(1.5),
      child: Obx(
        () {
          final userProfile = profileController.userProfile.value;
          if (userProfile != null && userProfile.profileImage!.isNotEmpty) {
            return CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(userProfile.profileImage!),
              minRadius: minRadius,
              backgroundColor: AppColors.primaryColor.withOpacity(0.22),
            );
          }
          return Shimmer.fromColors(
            baseColor: AppColors.activeBottomNevItemColor,
            highlightColor: AppColors.foregroundColor,
            child: CircleAvatar(
              minRadius: minRadius,
              backgroundColor: AppColors.primaryColor.withOpacity(0.22),
            ),
          );
        },
      ),
    ),
  );
}

Widget currentUserStatusPicture() {
  return Obx(
    () {
      final userProfile = profileController.userProfile.value;
      final statusImage = _statusController.statuses.isNotEmpty
          ? _statusController.statuses[0]
          : userProfile?.profileImage ?? '';

      if (statusImage.isNotEmpty) {
        _statusController.updateDominantColor(statusImage);
      }
      if (userProfile != null &&
          userProfile.profileImage != null &&
          userProfile.profileImage!.isNotEmpty) {
        return SizedBox(
          height: 120,
          width: 95,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: 95,
                  color: _statusController.dominantColor.value,
                  child: Image(
                    image: CachedNetworkImageProvider(statusImage),
                    fit: statusImage.isNotEmpty ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
                Container(
                  color: AppColors.secondaryColor.withOpacity(0.15),
                ),
              ],
            ),
          ),
        );
      }
      return Shimmer.fromColors(
        baseColor: AppColors.activeBottomNevItemColor,
        highlightColor: AppColors.foregroundColor,
        child: Container(
          height: 120,
          width: 95,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.22),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    },
  );
}

Widget othersStatusProfilePicture({required String profilePicture}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.primaryColor, borderRadius: BorderRadius.circular(50)),
    child: Padding(
      padding: const EdgeInsets.all(1.5),
      child: profilePicture.isNotEmpty
          ? CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profilePicture,
              ),
              backgroundColor: AppColors.activeBottomNevItemColor,
            )
          : Shimmer.fromColors(
              baseColor: AppColors.activeBottomNevItemColor,
              highlightColor: AppColors.foregroundColor,
              child: CircleAvatar(
                backgroundColor: AppColors.activeBottomNevItemColor,
              )),
    ),
  );
}

Widget othersStatusPicture({required List<String> statusPicture}) {
  return statusPicture.isNotEmpty
      ? Container(
          height: 120,
          width: 95,
          color: AppColors.activeBottomNevItemColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: CachedNetworkImageProvider(statusPicture[0]),
              height: 120,
              width: 95,
              fit: BoxFit.cover,
            ),
          ),
        )
      : Shimmer.fromColors(
          baseColor: AppColors.activeBottomNevItemColor,
          highlightColor: AppColors.foregroundColor,
          child: Container(
            height: 120,
            width: 95,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.22),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
}
