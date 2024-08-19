import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/profile/list_view_widget.dart';

Widget gridOrListViewSelectorSection(Size deviceSize) {
  return Column(
    children: [
      GetBuilder<ProfileScreenController>(builder: (profileScreenController) {
        return Row(
          children: [
            const Spacer(),
            postListLayout(() {
              profileScreenController.clickOnGridView();
            }, "Grid View", AssetsPath.grid,
                profileScreenController.isGridViewSelected),
            const SizedBox(width: 16),
            postListLayout(() {
              profileScreenController.clickOnListView();
            }, "List View", AssetsPath.list,
                !profileScreenController.isGridViewSelected),
            const Spacer()
          ],
        );
      }),
      Divider(
        height: 1,
        color: AppColors.secondaryColor.withOpacity(0.3),
        thickness: 1,
        indent: 1,
        endIndent: 1,
      ),
    ],
  );
}
