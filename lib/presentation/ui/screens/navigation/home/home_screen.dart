import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/ui/screens/welcome_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/app_logo.dart';
import 'package:socialive/presentation/ui/widgets/clear_catch.dart';
import 'package:socialive/presentation/ui/widgets/home/home_screen_icons_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/status_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StatusController _status = Get.put(StatusController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.textLightColor.withOpacity(0.2),
        body: RefreshIndicator(
          onRefresh: () async {},
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
                                onTap: () async {
                                  /// to logout for testing purposes
                                  deleteCacheDir();
                                  deleteAppDir();
                                  await FirebaseAuth.instance.signOut();
                                  Get.offAll(() => const WelComeScreen());
                                },
                                child: iconWithBG(
                                    imgPath: AssetsPath.notification)),
                            const SizedBox(width: 10),
                            iconWithBG(imgPath: AssetsPath.message),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          height: 155,
                          child: Obx(() {
                            final profiles =
                                _status.followingProfiles.values.toList();

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
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   padding: const EdgeInsets.only(top: 15),
                //   itemCount: posts.length + 1,
                //   itemBuilder: (context, index) {
                //     if (index == posts.length) {
                //       return noMorePosts();
                //     } else {
                //       return PostWidget(
                //         profileImage: posts[index]["profileImage"],
                //         username: posts[index]["userName"],
                //         handle: posts[index]["handle"],
                //         postImage: posts[index]["postImage"],
                //         commentCount: posts[index]["commentCount"],
                //       );
                //     }
                //   },
                // )
              ],
            ),
          ),
        ));
  }
}
