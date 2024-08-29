import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';

final PostController controller = Get.put(PostController());

Widget timelinePostImage({
  required String postImage,
}) {
  return GestureDetector(
    onDoubleTap: controller.toggleLike,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 327,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.textLightColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
            image: CachedNetworkImageProvider(postImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
