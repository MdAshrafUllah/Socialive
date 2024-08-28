import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/user_profile_model.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/screens/edit_profile_screen.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

Widget profileHeaderSection(Size deviceSize, UserProfile userData) {
  return Container(
    height: deviceSize.height * 0.24,
    color: AppColors.foregroundColor,
    padding: const EdgeInsets.all(10),
    width: double.maxFinite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("My Profile", style: AppFontStyle.satoshi700S20),
        SizedBox(height: deviceSize.height * 0.03),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.to(
                () => const EditProfileScreen(),
              ),
              child: currentUserProfilePicture(
                minRadius: 40,
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.name!, style: AppFontStyle.satoshi700S18),
                Text(
                  userData.userName!,
                  style: AppFontStyle.satoshi400S12
                      .copyWith(color: AppColors.textLightColor),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: [
                    Text(
                      "${userData.posts!.length}",
                      style: AppFontStyle.satoshi500S12,
                    ),
                    Text(
                      "Post",
                      style: AppFontStyle.satoshi400S12
                          .copyWith(color: AppColors.textLightColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${userData.following!.length}",
                      style: AppFontStyle.satoshi500S12,
                    ),
                    Text(
                      "Following",
                      style: AppFontStyle.satoshi400S12
                          .copyWith(color: AppColors.textLightColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${userData.followers!.length}",
                      style: AppFontStyle.satoshi500S12,
                    ),
                    Text(
                      "Follower",
                      style: AppFontStyle.satoshi400S12
                          .copyWith(color: AppColors.textLightColor),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
