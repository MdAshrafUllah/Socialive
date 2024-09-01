import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

Widget userListWidget(
    {required String name,
    required String userName,
    required String profileImage,
    required bool isFollowing,
    required VoidCallback onFollowTap,
    VoidCallback? onCardTap,
    bool showFollowButton = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: GestureDetector(
      onTap: onCardTap,
      child: Row(
        children: [
          globalProfilePicture(profilePicture: profileImage),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: AppFontStyle.satoshi700S14,
              ),
              Text(userName)
            ],
          ),
          const Spacer(),
          if (showFollowButton)
            GestureDetector(
              onTap: onFollowTap,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: isFollowing
                      ? AppColors.textLightColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      isFollowing ? "Unfollow" : "Follow",
                      style: AppFontStyle.satoshi400S14C2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
