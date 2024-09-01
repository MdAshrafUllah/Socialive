import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';

Widget noMorePosts() {
  return Column(
    children: [
      Divider(
        height: 10,
        color: AppColors.secondaryColor.withOpacity(0.1),
        thickness: 1,
      ),
      const Text(
        "You have no more posts to watch\nFollow More People\n😀\n",
        textAlign: TextAlign.center,
        style: AppFontStyle.satoshi500S16,
      ),
    ],
  );
}
