import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

Widget commentsBtn({required int commentCount}) {
  return GestureDetector(
    onTap: () {},
    child: Row(
      children: [
        SvgPicture.asset(
          AssetsPath.comment,
          height: 30,
          width: 30,
          colorFilter:
              ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
        ),
        const SizedBox(width: 3),
        Text(
          "$commentCount comments",
          style: AppFontStyle.satoshi500S14,
        )
      ],
    ),
  );
}
