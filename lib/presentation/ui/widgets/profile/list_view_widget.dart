import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';

Widget postListLayout(
    dynamic onTap, String buttonName, String iconPath, bool isSelected) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 30,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isSelected
                      ? AppColors.secondaryColor
                      : Colors.transparent))),
      child: Center(
          child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 16,
          ),
          const SizedBox(width: 2),
          Text(
            buttonName,
            style: AppFontStyle.satoshi700S14,
          ),
        ],
      )),
    ),
  );
}
