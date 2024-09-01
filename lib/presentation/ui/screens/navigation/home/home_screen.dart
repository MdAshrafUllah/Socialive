import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/welcome_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/app_logo.dart';
import 'package:socialive/presentation/ui/widgets/clear_catch.dart';
import 'package:socialive/presentation/ui/widgets/home/home_screen_icons_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/no_posts_message.dart';
import 'package:socialive/presentation/ui/widgets/home/timeline_posts_card_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/status_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _statusController = Get.find<StatusController>();
  final _postController = Get.find<PostController>();
  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.textLightColor.withOpacity(0.2),
        body: RefreshIndicator(
          onRefresh: () async {
            _statusController.fetchAllStatus();
            _postController.fetchAllPosts();
          },
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.foregroundColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            currentUserProfilePicture(
                              minRadius: 20,
                            ),
                            const Spacer(),
                            const AppLogo(),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {},
                                child: iconWithBG(
                                    imgPath: AssetsPath.notification)),
                            const SizedBox(width: 10),
                            iconWithBG(imgPath: AssetsPath.message),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () async {
                                  AppDataClear.deleteCacheDir();
                                  AppDataClear.deleteAppDir();
                                  await FirebaseAuth.instance.signOut();
                                  Get.offAll(() => const WelComeScreen());
                                },
                                child: iconWithBG(imgPath: AssetsPath.logout)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          height: 155,
                          child: Obx(() {
                            final profiles = _statusController
                                .followingProfiles.values
                                .toList();

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: profiles.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: currentUserStatusBox(),
                                  );
                                } else {
                                  final profile = profiles[index - 1];
                                  final name = profile.name;
                                  final profileImage = profile.profileImage;
                                  final statusList = profile.status;

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: othersStatusBox(
                                      profileImage: profileImage,
                                      statusImage: statusList.isNotEmpty
                                          ? statusList
                                          : [],
                                      userName: name,
                                    ),
                                  );
                                }
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 15)
                    ],
                  ),
                ),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: _postController.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _postController.posts.length) {
                          return noMorePosts();
                        } else {
                          return PostWidget(
                            currentUserId: _profileController.uid,
                            postUserId: _postController.posts[index].postUserId,
                            profileImage:
                                _postController.posts[index].profileImage,
                            name: _postController.posts[index].name,
                            userName: _postController.posts[index].userName,
                            postImage: _postController.posts[index].postImage,
                            postDescription:
                                _postController.posts[index].postDescription,
                            commentCount:
                                _postController.posts[index].comments.length,
                            likeCount: _postController.posts[index].likeCount,
                            postId: _postController.posts[index].postId,
                          );
                        }
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}
