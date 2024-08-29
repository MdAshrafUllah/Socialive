import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

Widget backButtonWithTittle(
    {bool isBackButtonEnable = true, required String title}) {
  return Column(
    children: [
      const SizedBox(height: 30),
      Row(
        children: [
          isBackButtonEnable
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(AssetsPath.leftArrow),
                )
              : const SizedBox(),
          isBackButtonEnable ? const SizedBox(width: 12) : const Spacer(),
          Text(
            title,
            style: AppFontStyle.satoshi700S20,
          ),
          isBackButtonEnable ? const SizedBox(width: 12) : const Spacer(),
        ],
      ),
    ],
  );
}
