import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

Widget customAppBar({
  bool isBackButtonEnable = false,
  required String title,
  String actionTitle = "",
  VoidCallback? onTapAction,
  VoidCallback? clearData,
  bool showAction = false,
}) {
  return Column(
    children: [
      const SizedBox(height: 30),
      Row(
        children: [
          if (isBackButtonEnable)
            GestureDetector(
              onTap: () {
                if (clearData != null) {
                  clearData();
                }
                Get.back();
              },
              child: SvgPicture.asset(AssetsPath.leftArrow),
            ),
          if (isBackButtonEnable) const SizedBox(width: 12),
          Text(
            title,
            style: AppFontStyle.satoshi700S20,
            textAlign: isBackButtonEnable ? TextAlign.left : TextAlign.center,
          ),
          showAction ? const Spacer() : const SizedBox(),
          showAction == true
              ? GestureDetector(
                  onTap: onTapAction,
                  child: Row(
                    children: [
                      Text(
                        actionTitle,
                        style: AppFontStyle.satoshi700S18C1,
                      ),
                      SvgPicture.asset(
                        AssetsPath.rightArrow,
                        colorFilter: ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
