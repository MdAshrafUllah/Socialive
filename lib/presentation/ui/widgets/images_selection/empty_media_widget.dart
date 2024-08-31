import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

class EmptyMediaView extends StatelessWidget {
  const EmptyMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetsPath.addImage,
          height: 80,
          width: 80,
          colorFilter: ColorFilter.mode(
              AppColors.inputFieldBorderColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 15),
        const Text("Add a Image", style: AppFontStyle.satoshi700S24),
        const Text("Choose a Image to add to your post.",
            style: AppFontStyle.satoshi500S16),
      ],
    );
  }
}
