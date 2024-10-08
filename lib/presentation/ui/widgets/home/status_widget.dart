import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/home/status_view_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';
import 'package:socialive/presentation/ui/widgets/upload_image_dialog.dart';

final StatusController _statusController = Get.find<StatusController>();
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
    child: GestureDetector(
      onTap: () {
        if (_statusController.statuses.isNotEmpty) {
          Get.to(() => StatusViewScreen(
                statusImage: _statusController.statuses,
                firstIndex: true,
              ));
        }
      },
      child: Column(
        children: [
          Stack(
            children: [
              currentUserStatusPicture(),
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
                  child: GestureDetector(
                    onTap: () => showUploadImageDialog(
                      fromCamera: _statusController.statusUploadFromCamera,
                      fromGallery: _statusController.statusUploadFromGallery,
                    ),
                    child: SvgPicture.asset(
                      AssetsPath.add,
                      colorFilter: ColorFilter.mode(
                        AppColors.foregroundColor,
                        BlendMode.srcIn,
                      ),
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
    ),
  );
}

Widget othersStatusBox({
  required String profileImage,
  required List<String> statusImage,
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
            GestureDetector(
                onTap: () =>
                    Get.to(() => StatusViewScreen(statusImage: statusImage)),
                child: othersStatusPicture(statusPicture: statusImage)),
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
