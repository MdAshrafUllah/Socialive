import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/following_followers_list_screen_controller.dart';

Widget followingFollowerSelectionSection() {
  return GetBuilder<FollowingFollowersListScreenController>(
      builder: (controller) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            controller.switchFollowToFollowers();
          },
          child: Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: controller.isFollowingScreen.value
                          ? AppColors.secondaryColor
                          : Colors.transparent,
                      width: 1.4),
                ),
              ),
              child: const Center(
                child: Text("Following", style: AppFontStyle.satoshi500S14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            controller.switchFollowToFollowers();
          },
          child: Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: !controller.isFollowingScreen.value
                          ? AppColors.secondaryColor
                          : Colors.transparent,
                      width: 1.4),
                ),
              ),
              child: const Center(
                child: Text("Followers", style: AppFontStyle.satoshi500S14),
              ),
            ),
          ),
        ),
      ],
    );
  });
}
