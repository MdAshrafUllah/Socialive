import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/profile/grid_or_list_view_selection_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/post_builder_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final postController = Get.find<PostController>();
  final followingFollowersController =
      Get.find<FollowingFollowersListController>();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () {
                  return profileHeaderSection(deviceSize);
                },
              ),
              Divider(
                height: 50,
                color: AppColors.secondaryColor.withOpacity(0.1),
                thickness: 10,
              ),
              Container(
                height: deviceSize.height * 0.6,
                width: deviceSize.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<ProfileController>(
                    builder: (profileScreenController) {
                  return Column(
                    children: [
                      gridOrListViewSelectorSection(deviceSize),
                      Obx(
                        () {
                          final posts = postController.currentUserAllPosts;
                          return Visibility(
                            visible: profileScreenController.isGridViewSelected,
                            replacement: postListViewBuilder(posts),
                            child: postGridViewBuilder(posts),
                          );
                        },
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
