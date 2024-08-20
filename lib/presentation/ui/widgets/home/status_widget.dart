import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';

Widget currentUserStatusBox() {
  return Container(
    height: 155,
    width: 95,
    decoration: BoxDecoration(
      color: AppColors.foregroundColor,
      border: Border.all(
        color: AppColors.textLightColor.withOpacity(0.2),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            currentUserStatusProfilePicture(),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: currentUserProfilePicture(
                    minRadius: 20,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: SvgPicture.asset(
                  AssetsPath.add,
                  colorFilter: ColorFilter.mode(
                    AppColors.foregroundColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          "You",
          style: AppFontStyle.satoshi700S12,
        ),
      ],
    ),
  );
}

Widget othersStatusBox({
  required String profileImage,
  required String statusImage,
  required String userName,
}) {
  return Container(
    height: 155,
    width: 95,
    decoration: BoxDecoration(
      color: AppColors.foregroundColor,
      border: Border.all(
        color: AppColors.textLightColor.withOpacity(0.2),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            othersStatusPicture(statusPicture: statusImage),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: othersStatusProfilePicture(
                    profilePicture: profileImage,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          userName,
          style: AppFontStyle.satoshi700S12,
        ),
      ],
    ),
  );
}
