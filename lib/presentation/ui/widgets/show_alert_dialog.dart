import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

void showAlertDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: AppColors.foregroundColor,
        title: Text(
          title,
          style: AppFontStyle.satoshi700S18C,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: AppFontStyle.satoshi400S14C,
          textAlign: TextAlign.center,
        ),
        actions: [
          elevatedBtn(
            btnName: 'Ok',
            onPressed: () => Get.back(),
          )
        ],
      );
    },
  );
}
