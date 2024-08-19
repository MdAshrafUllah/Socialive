import 'package:flutter/material.dart';
import 'package:socialive/Data/models/user_data.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

Widget profileHeaderSection(Size deviceSize, UserData userData) {
  return Container(
    height: deviceSize.height * 0.24,
    color: AppColors.foregroundColor,
    padding: const EdgeInsets.all(10),
    width: double.maxFinite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 38),
        const Text("My Profile", style: AppFontStyle.satoshi700S20),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            currentUserProfilePicture(
              minRadius: 40,
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.name, style: AppFontStyle.satoshi700S18),
                Text(
                  userData.userName,
                  style: AppFontStyle.satoshi400S12
                      .copyWith(color: AppColors.textLightColor),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: [
                    Text(
                      "${userData.numberOfPost}",
                      style: AppFontStyle.satoshi500S12,
                    ),
                    Text(
                      "Post",
                      style: AppFontStyle.satoshi400S12
                          .copyWith(color: AppColors.textLightColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${userData.following}",
                      style: AppFontStyle.satoshi500S12,
                    ),
                    Text(
                      "Following",
                      style: AppFontStyle.satoshi400S12
                          .copyWith(color: AppColors.textLightColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${userData.follower}",
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
