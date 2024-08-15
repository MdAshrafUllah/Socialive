import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

Widget elevatedBtn({
  required btnName,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        btnName,
        style: FontStyle.satoshi700S16,
      ),
    ),
  );
}

Widget textBtn({
  required String btnName,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          btnName,
          style: FontStyle.satoshi700S16,
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SvgPicture.asset(
            AssetsPath.downArrow,
            colorFilter:
                ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            fit: BoxFit.scaleDown,
            height: 20,
            width: 20,
          ),
        )
      ],
    ),
  );
}
