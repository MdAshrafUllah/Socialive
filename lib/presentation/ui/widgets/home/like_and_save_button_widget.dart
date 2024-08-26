import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

final PostController controller = Get.put(PostController());
Widget likedBtn() {
  return GestureDetector(
    onTap: controller.toggleLike,
    child: Obx(() => SvgPicture.asset(
          controller.isLiked.value ? AssetsPath.loveFill : AssetsPath.loveLine,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
              controller.isLiked.value
                  ? AppColors.likedColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn),
        )),
  );
}

Widget saveBtn() {
  return GestureDetector(
    onTap: controller.toggleSave,
    child: Obx(() => SvgPicture.asset(
          controller.isSaved.value
              ? AssetsPath.bookmarkFill
              : AssetsPath.bookmark,
          height: 30,
          width: 30,
          colorFilter:
              ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
        )),
  );
}
