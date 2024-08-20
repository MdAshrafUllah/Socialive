import 'package:flutter/material.dart';

import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';

import 'package:socialive/presentation/ui/widgets/home/comments_button_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/like_and_save_button_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/post_image_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

class PostWidget extends StatelessWidget {
  final String profileImage;
  final String username;
  final String handle;
  final String postImage;
  final int commentCount;

  const PostWidget({
    super.key,
    required this.profileImage,
    required this.username,
    required this.handle,
    required this.postImage,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.foregroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  othersStatusProfilePicture(profilePicture: profileImage),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: AppFontStyle.satoshi700S16,
                      ),
                      Text(
                        handle,
                        style: AppFontStyle.satoshi400S12C,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.secondaryColor,
                    size: 25,
                  )
                ],
              ),
              timelinePostImage(postImage: postImage),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    likedBtn(),
                    const SizedBox(width: 10),
                    commentsBtn(commentCount: commentCount),
                    const Spacer(),
                    saveBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}