import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/user_profile_model.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/profile/grid_or_list_view_selection_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/post_builder_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

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
                  final userProfile = profileController.userProfile.value;
                  if (userProfile != null) {
                    return profileHeaderSection(
                      deviceSize,
                      UserProfile(
                        name: userProfile.name!,
                        userName: '@${userProfile.userName}',
                        posts: userProfile.posts,
                        following: userProfile.following,
                        followers: userProfile.followers,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Divider(
                height: 50,
                color: AppColors.secondaryColor.withOpacity(0.1),
                thickness: 10,
              ),
              Container(
                height: deviceSize.height - deviceSize.height / 3.8 - 8,
                width: deviceSize.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: AppColors.foregroundColor,
                child: GetBuilder<ProfileController>(
                    builder: (profileScreenController) {
                  return Column(
                    children: [
                      gridOrListViewSelectorSection(deviceSize),
                      Obx(
                        () {
                          final posts = profileScreenController
                                  .userProfile.value?.posts ??
                              [];
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
