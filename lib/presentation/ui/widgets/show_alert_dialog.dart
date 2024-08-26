import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

void showAlertDialog({
  Widget? topIcons,
  required String title,
  String? content,
  bool barrierDismissible = true,
  bool skipBtn = false,
  String elevatedBtnName = "Ok",
  String textBtnName = "Skip",
  VoidCallback? onElevatedBtnPressed,
  VoidCallback? onTextBtnPressed,
}) {
  Get.dialog(
    barrierDismissible: barrierDismissible,
    AlertDialog(
      surfaceTintColor: AppColors.foregroundColor,
      title: Column(
        children: [
          if (topIcons != null) topIcons,
          Text(
            title,
            style: AppFontStyle.satoshi700S18C,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: content != null
          ? Text(
              content,
              style: AppFontStyle.satoshi400S14C,
              textAlign: TextAlign.center,
            )
          : null,
      actions: [
        elevatedBtn(
          btnName: elevatedBtnName,
          onPressed: onElevatedBtnPressed ?? () => Get.back(),
        ),
        skipBtn
            ? textBtn(
                btnName: textBtnName,
                onPressed: onTextBtnPressed ?? () => Get.back(),
              )
            : const SizedBox(),
      ],
    ),
  );
}
