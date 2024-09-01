import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';

Widget iconWithBG({required String imgPath}) {
  return CircleAvatar(
    child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: SvgPicture.asset(
          imgPath,
          colorFilter:
              ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
          fit: BoxFit.scaleDown,
        )),
  );
}
