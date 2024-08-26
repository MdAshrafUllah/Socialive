import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/demo_data/user_upload_images.dart';
import 'package:socialive/Data/models/user_data.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/profile/grid_or_list_view_selection_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/post_builder_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_info_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override

  @override
  Widget build(BuildContext context) {
    UserData userData = UserData(
      name: "Ferdaous Mondal",
      userName: "@mferdous12",
      numberOfPost: 59,
      following: 125,
      follower: 850,
    );
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileHeaderSection(deviceSize, userData),
            Divider(
              height: 20,
              color: AppColors.secondaryColor.withOpacity(0.1),
              thickness: 10,
            ),
            Container(
              height: deviceSize.height - deviceSize.height / 3.8 - 8,
              width: deviceSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.foregroundColor,
              child: GetBuilder<ProfileScreenController>(
                  builder: (profileScreenController) {
                    return Column(
                      children: [
                        gridOrListViewSelectorSection(deviceSize),
                        Visibility(
                          visible: profileScreenController.isGridViewSelected,
                          replacement: postListViewBuilder(images),
                          child: postGridViewBuilder(images),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}