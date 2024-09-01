import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

Widget topSection({
  required String following,
  required String follower,
  required String posts,
  required bool isFollowing,
  required String bio,
  VoidCallback? follow,
  VoidCallback? message,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            posts,
            style: AppFontStyle.satoshi700S14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text('Posts',
              style: AppFontStyle.satoshi700S14
                  .copyWith(color: AppColors.textLightColor)),
          const SizedBox(
            width: 8,
          ),
          Text(
            following,
            style: AppFontStyle.satoshi700S14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text('Following',
              style: AppFontStyle.satoshi700S14
                  .copyWith(color: AppColors.textLightColor)),
          const SizedBox(
            width: 8,
          ),
          Text(
            follower,
            style: AppFontStyle.satoshi700S14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text('Followers',
              style: AppFontStyle.satoshi700S14
                  .copyWith(color: AppColors.textLightColor)),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        bio,
        style: AppFontStyle.satoshi500S14,
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          profileBtn(
            title: !isFollowing ? 'Follow' : 'Unfollow',
            onTap: () => follow,
            isFollow: !isFollowing,
          ),
          const SizedBox(
            width: 15,
          ),
          profileBtn(
            title: 'Message',
            onTap: () => message,
          ),
        ],
      )
    ],
  );
}
