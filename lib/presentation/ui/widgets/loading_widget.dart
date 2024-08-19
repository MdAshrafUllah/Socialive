import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/loading_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

final LoadingController loadingController = Get.find<LoadingController>();

Widget loadingAnimation() {
  return Center(
    child: RotationTransition(
      turns: loadingController.animationController,
      child: SvgPicture.asset(
        AssetsPath.loader,
        width: 100,
        height: 100,
      ),
    ),
  );
}
