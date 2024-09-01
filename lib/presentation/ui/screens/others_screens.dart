import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/others_screen_controller.dart';

import 'package:socialive/presentation/ui/widgets/custom_app_bar.dart';
import 'package:socialive/presentation/ui/widgets/others_profile_follower_and_posts.dart';
import 'package:socialive/presentation/ui/widgets/profile/grid_or_list_view_selection_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/post_builder_widget.dart';

class OtherUsersScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final bool isFollowing;
  final String uid;
  const OtherUsersScreen({
    super.key,
    required this.name,
    required this.profileImage,
    required this.isFollowing,
    required this.uid,
  });

  @override
  State<OtherUsersScreen> createState() => _OtherUsersScreenState();
}

class _OtherUsersScreenState extends State<OtherUsersScreen> {
  final postController = Get.find<PostController>();
  final othersScreenController = Get.find<OthersScreenController>();
  final followingFollowersListController =
      Get.find<FollowingFollowersListController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    othersScreenController.fetchUserData(uid: widget.uid);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: customAppBar(
                title: widget.name,
                isBackButtonEnable: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(widget.profileImage),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  topSection(
                    isFollowing: widget.isFollowing,
                    follower:
                        othersScreenController.userInfo['followers'].toString(),
                    following:
                        othersScreenController.userInfo['following'].toString(),
                    posts: othersScreenController.userPosts.length.toString(),
                    bio: othersScreenController.userInfo['bio'] ?? '',
                    follow: () => followingFollowersListController
                        .toggleFollow(widget.uid),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.8,
              width: size.width,
              color: AppColors.inputFieldBorderColor.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GetBuilder<ProfileController>(
                    builder: (profileScreenController) {
                  return Column(
                    children: [
                      gridOrListViewSelectorSection(size),
                      Obx(
                        () {
                          final List<String> allPostImages =
                              othersScreenController.userPosts
                                  .expand((postImages) => postImages)
                                  .toList();

                          return Visibility(
                            visible: profileScreenController.isGridViewSelected,
                            replacement: postListViewBuilder(allPostImages),
                            child: postGridViewBuilder(allPostImages),
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
