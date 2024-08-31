import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/expandable_text_widget.dart';

import 'package:socialive/presentation/ui/widgets/home/comments_button_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/like_and_save_button_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/post_image_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

final _postController = Get.find<PostController>();

class PostWidget extends StatelessWidget {
  final String profileImage;
  final String name;
  final String userName;
  final List<String> postImage;
  final String postDescription;
  final int commentCount;
  final int likeCount;
  final String postId;
  final String postUserId;
  final String currentUserId;

  const PostWidget({
    super.key,
    required this.profileImage,
    required this.name,
    required this.userName,
    required this.postImage,
    required this.postDescription,
    required this.commentCount,
    required this.likeCount,
    required this.postId,
    required this.postUserId,
    required this.currentUserId,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  globalProfilePicture(profilePicture: profileImage),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppFontStyle.satoshi700S16,
                      ),
                      Text(
                        "@$userName",
                        style: AppFontStyle.satoshi400S12C,
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (currentUserId == postUserId)
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            height: 15,
                            onTap: () {
                              showAlertDialog(
                                topIcons: Image.asset(AssetsPath.alert),
                                title: "Do you want to Delete this Post?",
                                elevatedBtnName: "Delete",
                                textBtnName: "Cancel",
                                onElevatedBtnPressed: () {
                                  Get.back();
                                  _postController.deletePost(postId);
                                },
                                skipBtn: true,
                                onTextBtnPressed: () {
                                  Get.back();
                                },
                              );
                            },
                            child: const Text(
                              'Delete',
                              style: AppFontStyle.satoshi400S12,
                            ),
                          ),
                        ];
                      },
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.secondaryColor,
                        size: 25,
                      ),
                    ),
                ],
              ),
              timelinePostImage(postImage: postImage[0]),
              postDescription.isNotEmpty
                  ? ExpandableText(
                      text: postDescription,
                      style: AppFontStyle.satoshi500S16,
                      maxLines: 2,
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    likedBtn(likeCount: likeCount),
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
