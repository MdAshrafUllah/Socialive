import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

showUploadImageDialog(
    {required VoidCallback fromCamera, required VoidCallback fromGallery}) {
  Get.dialog(
    AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      surfaceTintColor: AppColors.foregroundColor,
      title: Text(
        "Select From",
        style: AppFontStyle.satoshi700S18C,
        textAlign: TextAlign.center,
      ),
      actions: [
        Column(
          children: [
            GestureDetector(
                onTap: fromCamera,
                child: SvgPicture.asset(
                  AssetsPath.camera,
                  height: 100,
                  width: 100,
                )),
            const Text("Camera", style: AppFontStyle.satoshi700S14),
          ],
        ),
        Column(
          children: [
            GestureDetector(
                onTap: fromGallery,
                child: SvgPicture.asset(
                  AssetsPath.gallery,
                  height: 100,
                  width: 100,
                )),
            const Text("Gallery", style: AppFontStyle.satoshi700S14),
          ],
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
