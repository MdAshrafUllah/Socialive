import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/navigation/profile/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/profile/following_followers_list_screen.dart';
import 'package:socialive/presentation/ui/screens/navigation/profile/edit_profile_screen.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

final followerListController = Get.find<FollowingFollowersListController>();
final postController = Get.find<PostController>();
final profileController = Get.find<ProfileController>();

Widget profileHeaderSection(Size deviceSize) {
  final name = profileController.userProfile.value!.name ?? '';
  final userName = profileController.userProfile.value!.userName ?? '';
  final postsCount = profileController.postsCount;

  return Container(
    height: deviceSize.height * 0.26,
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
                Text(name, style: AppFontStyle.satoshi700S20),
                Text(
                  "@$userName",
                  style: AppFontStyle.satoshi700S14
                      .copyWith(color: AppColors.textLightColor),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: [
                    Text(
                      postsCount.toString(),
                      style: AppFontStyle.satoshi700S14,
                    ),
                    Text(
                      "Post",
                      style: AppFontStyle.satoshi700S14
                          .copyWith(color: AppColors.textLightColor),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => FollowingFollowerListScreen(name: name),
                        );
                        followerListController.isFollowingScreen(true);
                      },
                      child: Row(
                        children: [
                          Text(
                            profileController
                                    .userProfile.value!.following?.length
                                    .toString() ??
                                '0',
                            style: AppFontStyle.satoshi700S14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Following",
                            style: AppFontStyle.satoshi700S14
                                .copyWith(color: AppColors.textLightColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => FollowingFollowerListScreen(name: name),
                        );
                        followerListController.isFollowingScreen(false);
                      },
                      child: Row(
                        children: [
                          Text(
                            profileController
                                    .userProfile.value!.followers?.length
                                    .toString() ??
                                '0',
                            style: AppFontStyle.satoshi700S14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Followers",
                            style: AppFontStyle.satoshi700S14
                                .copyWith(color: AppColors.textLightColor),
                          ),
                        ],
                      ),
                    )
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
